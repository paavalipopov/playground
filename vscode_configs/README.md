# VS Code config backup

Git-tracked backup of my VS Code setup. VS Code points to config files via symlinks (see `link.sh`), so editing settings in the editor updates the git-tracked copy directly.

## Contents
- `workspaces/` — saved workspaces
- `keybindings.json` — keyboard shortcuts (symlinked)
- `settings.json` — user settings (symlinked)
- `snippets/` — user code snippets (symlinked)
- `extensions.txt` — list of installed extensions

## Setup on a machine
```bash
bash link.sh              # migrate config files here + create symlinks
bash export-extensions.sh # refresh extensions.txt
```