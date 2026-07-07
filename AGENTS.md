# AGENTS.md

This file provides guidance to coding agents working in this dotfiles repository. `CLAUDE.md` intentionally just references this file with `@AGENTS.md`.

## Repository Map

- `do_deploy.sh`: symlink-based deploy script.
- `deploy/*.deploy`: source/destination manifests consumed by `do_deploy.sh`.
- `deploy/*.deploy.after`: optional post-deploy hooks.
- `shell/`: shell, zsh, and prompt startup files.
- `git/`: shared Git config and global ignore file.
- `tmux/`: tmux config and status helpers.
- `astronvim/v5/`: active Neovim config, deployed to `~/.config/nvim`.
- `vim/`: legacy Vim/Neovim config, deployed to `~/.vim`.
- `hammerspoon/init.lua`: macOS Hammerspoon config.
- `astronvim/v3/`, `astronvim/v4/`, `archived/`: retained older configs; do not treat them as active unless the task explicitly asks.

## Deployment

Use the deploy script from the repo root:

```bash
./do_deploy.sh              # deploy all *.deploy groups
./do_deploy.sh shell        # shell, tmux, git, terminfo, p10k
./do_deploy.sh astronvim    # active Neovim config
./do_deploy.sh vim          # legacy Vim config
./do_deploy.sh macos        # Hammerspoon config
```

Each deploy manifest is a whitespace-separated `<source> <destination>` list. `do_deploy.sh` resolves `$OS` from `/etc/os-release` on Linux, so Ubuntu-specific shell files are named `shell/profile.ubuntu` and `shell/zshrc.ubuntu`; on macOS `$OS` is `macos`.

Deploy behavior:

- Existing symlinks at destinations are removed.
- Existing regular files are copied into `oldconfigs/` with a date suffix.
- Existing directories are moved into `oldconfigs/` with a date suffix.
- Directory destinations ending in `/` are created before symlinking.
- A matching `deploy/<group>.deploy.after` hook runs after that group.

The `shell` post-hook compiles terminfo entries into `~/.terminfo`, runs `git config --global include.path ~/.gitconfig.shared`, and clones powerlevel10k into `~/.p10k` if missing. That clone needs network access.

## Shell And Zsh

`shell/profile` is the portable environment file. It guards against double sourcing with `_DOTFILES_PROFILE_LOADED`, prepends `~/.local/bin`, sets `EDITOR` based on `nvim`, sets `TERM=xterm-256color`, then sources `~/.profile.native`, `~/.profile.local`, and `~/.local/bin/env` if present.

`shell/zprofile` sources `~/.profile` for login shells. `shell/zshenv` also sources `~/.profile`, so non-interactive zsh commands get the same environment.

`shell/zshrc` is standalone interactive zsh configuration. It does not load oh-my-zsh. It sets up cached `compinit`, history, keybindings, color aliases, git aliases, tmux refresh-on-cd, OS/local interactive overrides, and powerlevel10k. It prefers `${P10K_DIR:-/usr/local/share/powerlevel10k}` and falls back to `~/.p10k`.

Machine-specific shell overrides belong outside the repo in:

- `~/.profile.local`
- `~/.zshrc.local`
- `~/.local/bin/env`

## Neovim

The active Neovim config is `astronvim/v5/`. `deploy/astronvim.deploy` links that directory to `~/.config/nvim`.

AstroNvim v5 is bootstrapped by `astronvim/v5/init.lua`, which loads `lua/lazy_setup.lua` and then `lua/polish.lua`. Lazy imports run in this order:

1. `AstroNvim/AstroNvim`
2. `lua/community.lua`
3. `lua/plugins/*.lua`

Put new active Neovim plugin overrides in `astronvim/v5/lua/plugins/`. Key mappings live in `astronvim/v5/lua/mappings.lua` and are loaded by `plugins/astrocore.lua`.

Network filesystem behavior is centralized around `vim.g.network_fs`, set in `astronvim/v5/init.lua`. Detection uses `vim.uv.fs_statfs()` for Lustre, FUSE/sshfs, NFS, and CIFS/SMB, and can be overridden with `NVIM_NETWORK_FS=1` or `NVIM_NETWORK_FS=0`.

Current network-FS consumers:

- `plugins/neo-tree.lua`: disables expensive git status, watchers, gitignore checks, and metadata columns on network filesystems.
- `plugins/snacks.lua`: disables file picker symlink following on network filesystems.
- `plugins/performance.lua`: keeps selected expensive plugins disabled on network filesystems and defers `smart-splits.nvim` loading.

When changing network-FS behavior, prefer adding narrowly scoped consumers of `vim.g.network_fs` rather than scattering filesystem detection logic into individual plugin files.

## Tmux

`tmux/tmux.conf` uses `C-s` as prefix, vi copy-mode keys, mouse support, custom session/window/pane bindings, and a three-line status area. `tmux/tmux.remote.conf` is sourced quietly when `$SSH_CLIENT` is set and swaps the status line to remote CPU/memory helpers from `tmux/`.

Local tmux-only overrides belong in `~/.tmux.conf.local`, which is sourced quietly by `tmux/tmux.conf`.

The shell deploy group links:

- `tmux/tmux.conf` to `~/.tmux.conf`
- `tmux/tmux.remote.conf` to `~/.tmux/tmux.remote.conf`
- `tmux/cpu_usage.sh` and `tmux/mem_usage.sh` into `~/.tmux/`

## Legacy Vim

`deploy/vim.deploy` links `vim/init.vim` to `~/.vim/vimrc`, copies `vim/*` into `~/.vim/`, and links Vim color themes into `~/.vim/colors/`. `deploy/vim.deploy.after` installs vim-plug to `~/.vim/autoload/plug.vim` with `curl` if it is missing; this requires network access.

`vim/init.vim` sources:

- `vim/config.vim`
- `vim/functions.vim`
- `vim/mappings.vim`
- `vim/plugin.vim`
- `vim/autocmd.vim`
- `vim/filetype.vim`

Neovim should use `astronvim/v5/`; do not reintroduce a second Neovim config path under `vim/`.

`vim/plugin.vim` uses vim-plug and sources plugin snippets from `vim/plugins/`. This is not the active AstroNvim config. vim-plug itself is expected at `~/.vim/autoload/plug.vim`, and plugin checkouts go under `~/.vim/plugged` unless `g:legacy_vim_plugged_dir` is overridden before sourcing `vim/plugin.vim`.

`vim/README.md` documents the user-facing legacy Vim fallback behavior, plugin list, deploy hook, and AstroNvim-aligned mappings.

The legacy Vim config must remain usable without Neovim, vim-plug, or installed plugins. Plugin loading is skipped when `plug#begin()` is unavailable, and automatic plugin installation is disabled unless `g:legacy_vim_auto_install_plugins` is set.

Keep the legacy Vim plugin set minimal. The current optional plugins are `vim-commentary`, `vim-easymotion`, `preservim/nerdtree`, `vim-repeat`, and `vim-surround`; built-in Vim features still cover the buffer tabline, statusline, syntax/filetype support, tag jumps, and netrw fallback when NERDTree is not installed. Keep high-frequency UX aligned with `astronvim/v5/lua/mappings.lua`: `;` starts character-hint cursor jumping, `<leader>d` toggles the tree, `sf` focuses/reveals in the tree, `s|`/`s_` split the current buffer, `sh`/`sj`/`sk`/`sl` move across windows, Ctrl-arrow resizes windows, `<leader>;`/`<leader>l` navigate buffer tabs, and `<C-d>`/`<C-i>` move 15 lines. Do not add language servers, fuzzy finders, statusline frameworks, auto-taggers, NERDTree extension plugins, or Neovim-only plugins here unless the fallback use case specifically requires them.

## macOS

`deploy/macos.deploy` links `hammerspoon/init.lua` to `~/.hammerspoon/init.lua`. The Hammerspoon config binds app toggles and ShiftIt window-management shortcuts, then optionally loads `initLocal` via `pcall(require, "initLocal")`.

Machine-specific Hammerspoon config should live outside the repo as `~/.hammerspoon/initLocal.lua`.

## Git And Ignore Files

`git/gitconfig.shared` is included globally by the shell deploy hook. `git/gitignore_global` is deployed to `~/.config/git/ignore`.

Repo-local `.gitignore` only ignores `oldconfigs/`, `.codex`, and `.claude/`. `git/gitignore_global` currently ignores common generated files plus Claude local state such as `**/.claude/settings.local.json` and `**/.claude/.cc-writes/`.

Do not commit machine-local or secret-bearing files. In this repo, be especially careful with `.claude/settings.local.json`, local shell overrides, and any Hammerspoon local module.
