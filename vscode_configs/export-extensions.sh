#!/usr/bin/env bash
# Save the list of installed VS Code extensions so they can be reinstalled later.
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
code --list-extensions > "$REPO/extensions.txt"
echo "Wrote $(wc -l < "$REPO/extensions.txt") extensions to extensions.txt"
echo "Reinstall with:  xargs -L1 code --install-extension < \"$REPO/extensions.txt\""
