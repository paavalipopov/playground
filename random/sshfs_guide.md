# Read-Only SSHFS Mount — GSU Cluster (Apple Silicon Mac)

Mount a remote cluster directory as a **read-only** local folder, safe to point Claude Code / Cowork at. Read-only is enforced client-side by the `-o ro` flag.

---

## 1. SSH config

Add to `~/.ssh/config` (replace `<username>` with your own):

```ssh_config
Host trddata
    User <username>
    HostName arctrdcn017.rs.gsu.edu
    ForwardAgent no
```


---

## 2. FUSE + SSHFS (the combo that works on managed Apple Silicon)


We need a FUSE thing (file system something) + sshFS compatible with it.
The two below don't require IT or messing with settings in the recovery mode.

```bash
brew install --cask fuse-t
brew install macos-fuse-t/homebrew-cask/fuse-t-sshfs
```

---

## 3. Mount

Let's try to mount my datasets folder as datasets_remote.

```bash
mkdir -p ~/_remote_data/datasets_remote

sshfs trddata:/data/users2/ppopov1/datasets ~/_remote_data/datasets_remote \
  -o ro,reconnect
```

Flags:
- `ro` — read-only (the safety guarantee; writes rejected at the mount)
- `reconnect` — auto-recover if the network drops

Check out the mounted thing in terminal and Finder, should work.

---

## 4. Verify read-only

```bash
mount | grep _remote_data                       # should show "read-only" / "ro"
touch ~/_remote_data/datasets_remote/.write_test   # should FAIL: "Read-only file system"
```

---

## 5. Unmount

```bash
umount ~/_remote_data/datasets_remote
# if "busy":
diskutil unmount force ~/_remote_data/datasets_remote
```

Or click the eject icon in the Finder sidebar.

---

## 6. Aliases
I've wrapped the mounting/unmounting logic into aliases.
Examples: 
```bash
rmount /data/users2/ppopov1/datasets          # -> ~/_remote_data/datasets
rmount /data/users2/ppopov1/datasets fmri     # optional label -> ~/_remote_data/fmri
runmount datasets                             # unmount one
runmount                                      # prompt to unmount all
```

To make them work:

- Open your shell config:

```bash
open -e ~/.zshrc      # TextEdit; or: nano ~/.zshrc  /  code ~/.zshrc
```

- Paste the two functions from below and save.

- Source the updated config:

```bash
source ~/.zshrc       # or just open a new terminal tab
```

- Check they're loaded:

```bash
type rmount           # should print "rmount is a shell function"
```

Note: `sync_readdir` in the mount options makes directory listings synchronous — it seems to help with broken mounts when something (e.g. Claude) is reading the tree heavily at the same time. 
If it keep happening, other things to try are adding `max_conns=4` (parallel channels) or `cache=no`.

## FUNCTIONS:
```zsh
# read-only mount of a remote dir under ~/_remote_data/<basename>
# usage: rmount /data/users2/ppopov1/datasets [label]
rmount() {
  local remote="${1%/}"
  local host="trddata"
  [[ -z "$remote" ]] && { echo "usage: rmount <remote-path> [label] (e.g., rmount /data/users2/ppopov1/datasets)"; return 1; }

  local name="${2:-${remote:t}}"        # optional 2nd arg = folder/label name
  local mp="$HOME/_remote_data/$name"

  # refuse if the mountpoint already exists (active mount or stale leftover folder)
  [[ -e "$mp" ]] && { echo "rmount: $mp already exists — unmount it first (runmount $name) or remove the stale folder"; return 1; }
  mkdir -p "$mp"

  local opts="ro,reconnect,idmap=user,defer_permissions,sync_readdir,ServerAliveInterval=15,ServerAliveCountMax=3"

  sshfs "$host:$remote" "$mp" -o "$opts" || { echo "mount failed"; return 1; }
  echo "mounted $host:$remote -> $mp (read-only)"
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
```