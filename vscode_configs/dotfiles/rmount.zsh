# read-only mount of a remote dir under ~/_remote_data/<basename>
# usage: rmount /data/users2/ppopov1/datasets [label]
# read-only mount of a remote dir under ~/_remote_data/<basename>
# usage: rmount /data/users2/ppopov1/datasets [label]
rmount() {
  local remote="${1%/}"
  local host="trddata"
  [[ -z "$remote" ]] && { echo "usage: rmount <remote-path> [label] (e.g., rmount /data/users2/ppopov1/datasets)"; return 1; }

  local name="${2:-${remote:t}}"
  local mp="$HOME/_remote_data/$name"

  # refuse if it's actually in the mount table (live, or dead-but-still-listed)
  if mount | awk '{print $3}' | grep -qxF "$mp"; then
    echo "rmount: $mp is still mounted — run 'runmount $name' or 'rremount' first"; return 1
  fi

  # refuse if the folder exists and holds real content; an empty orphan folder
  # (left by a dropped mount) is fine to reuse. a stray .DS_Store is ignored.
  if [[ -d "$mp" ]]; then
    local leftovers=("$mp"/*(DN))               # D=include dotfiles, N=nullglob
    leftovers=(${leftovers:#$mp/.DS_Store})     # don't count a macOS .DS_Store
    (( ${#leftovers} )) && { echo "rmount: $mp is not empty — refusing to mount over existing files"; return 1; }
  fi

  mkdir -p "$mp"                                 # no-op if the orphan folder already exists

  local opts="ro,reconnect,idmap=user,defer_permissions,sync_readdir,ServerAliveInterval=15,ServerAliveCountMax=3"

  sshfs "$host:$remote" "$mp" -o "$opts" || { echo "mount failed"; return 1; }
  # save a copy-pasteable remount command
  local cmd="rmount ${(q)remote}"
  [[ -n "$2" ]] && cmd+=" ${(q)2}"
  echo "$cmd" > "$HOME/_remote_data/.$name.src"
  echo "mounted $host:$remote -> $mp (read-only)"
}

# liveness probe
_rmount_alive() {
  local mp="$1" f
  f=$(find "$mp" -maxdepth 1 -type f -size +0c 2>/dev/null | head -1)
  [[ -n "$f" ]] && head -c1 "$f" >/dev/null 2>&1
}

# rremount: scan live mounts, rebuild the dead ones from their .src sidecars
rremount() {
  local base="$HOME/_remote_data"
  local mounts=(${(f)"$(mount | grep -F " $base/" | awk '{print $3}')"})
  (( ${#mounts} == 0 )) && { echo "no active mounts under $base"; return 0; }

  local mp name src
  local -a cmd
  for mp in "${mounts[@]}"; do
    name="${mp:t}"
    if _rmount_alive "$mp"; then
      echo "alive: $name"
      continue
    fi
    src="$base/.$name.src"
    [[ -f "$src" ]] || { echo "dead:  $name — no .src saved, remount by hand"; continue; }

    cmd=(${(Q)${(z)"$(<"$src")"}})                                    # split saved line into words
    [[ "${cmd[1]}" == rmount ]] || cmd=(rmount "$(<"$src")" "$name")  # legacy: bare path

    echo "dead:  $name — rebuilding: ${cmd[*]}"
    ( cd ~ && runmount "$name" ) >/dev/null 2>&1                      # cd out so unmount isn't blocked
    "${cmd[@]}" >/dev/null && echo "       ok" || echo "       FAILED"
  done
}

# unmount by name; with no arg, offer to unmount everything under _remote_data
# removes the mountpoint folder afterward if it's empty
runmount() {
  local base="$HOME/_remote_data"

  _runmount_one() {
    local mp="$1"
    umount "$mp" 2>/dev/null || diskutil unmount force "$mp" 2>/dev/null
    # clean up the folder only if it's now empty (rmdir refuses non-empty dirs)
    [[ -d "$mp" ]] && rmdir "$mp" 2>/dev/null
  }

  if [[ -n "$1" ]]; then
    _runmount_one "$base/${1:t}"
    return
  fi

  # no arg: find live mounts under _remote_data
  local mounts=(${(f)"$(mount | grep -F " $base/" | awk '{print $3}')"})
  if (( ${#mounts} == 0 )); then
    echo "no active mounts under $base"
    return
  fi

  echo "active mounts:"
  printf '  %s\n' "${mounts[@]}"
  echo -n "unmount all ${#mounts} of them? [y/N] "
  local reply; read -r reply
  [[ "$reply" == [yY] ]] || { echo "aborted"; return 1; }

  local mp
  for mp in "${mounts[@]}"; do
    _runmount_one "$mp"
  done
}