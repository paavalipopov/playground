#!/usr/bin/env bash
# Move VS Code User config files into this git-tracked folder, then replace the
# originals with symlinks. Git stores the REAL content; VS Code reads/writes
# through the symlink, so the two stay in sync. Safe to re-run (idempotent).
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_DIR="$HOME/Library/Application Support/Code/User"

link() {
  local name="$1"
  local src="$USER_DIR/$name"   # where VS Code looks
  local dst="$REPO/$name"        # git-tracked real file

  if [ -L "$src" ]; then
    echo "= $name already a symlink"
    return
  fi

  if [ -e "$src" ] && [ ! -e "$dst" ]; then
    mv "$src" "$dst"                      # first-time migration
    echo "> moved $name into repo"
  elif [ -e "$src" ] && [ -e "$dst" ]; then
    mv "$src" "$src.bak.$(date +%s)"      # keep repo copy, back up the other
    echo "> backed up existing $name (kept repo copy)"
  fi

  if [ -e "$dst" ]; then
    ln -s "$dst" "$src"
    echo "+ linked $name"
  else
    echo ". no $name to link"
  fi
}

link keybindings.json
link settings.json
link snippets          # a directory; symlinks fine too

echo
echo "Done. Verify:  ls -l \"$USER_DIR\""
