# Dotfiles

Dotfiles for shell, Git, tmux, Neovim, Vim, and macOS Hammerspoon. Configs are deployed by symlinking files from this repository into their expected locations.

## Layout

- `shell/`: profile, zsh, and prompt config.
- `git/`: shared Git config and global ignore file.
- `tmux/`: tmux config and status helpers.
- `astronvim/v5/`: active Neovim config.
- `vim/`: legacy Vim fallback config.
- `hammerspoon/`: macOS Hammerspoon config.
- `deploy/`: deploy manifests and post-deploy hooks.

## Deploy

Run from the repo root:

```bash
./do_deploy.sh              # deploy all groups
./do_deploy.sh shell        # shell, tmux, git, terminfo, p10k
./do_deploy.sh astronvim    # Neovim config
./do_deploy.sh vim          # Vim fallback
./do_deploy.sh macos        # Hammerspoon config
```

Existing files or directories at deploy destinations are backed up into `oldconfigs/` before symlinks are created.

## Notes

- Neovim uses AstroNvim v5 from `astronvim/v5/`; see `astronvim/v5/README.md`.
- Vim uses the fallback config in `vim/`; see `vim/README.md`.
- Machine-local shell overrides belong in `~/.profile.local`, `~/.zshrc.local`, or `~/.local/bin/env`.
- Machine-local Hammerspoon overrides belong in `~/.hammerspoon/initLocal.lua`.
