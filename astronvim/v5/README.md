# AstroNvim v5 Config

This is the active Neovim config for this dotfiles repo. `deploy/astronvim.deploy` links this directory to `~/.config/nvim`; legacy Vim fallback config lives separately under `vim/`.

## Deploy

From the repo root:

```bash
./do_deploy.sh astronvim
```

The deploy script replaces an existing `~/.config/nvim` symlink, and moves any existing real directory or file into `oldconfigs/` with a date suffix before linking this directory.

## Layout

- `init.lua`: detects network filesystems, bootstraps `lazy.nvim`, then loads `lua/lazy_setup.lua` and `lua/polish.lua`.
- `lua/lazy_setup.lua`: imports AstroNvim v5, AstroCommunity modules, then local specs from `lua/plugins/`.
- `lua/community.lua`: imports AstroCommunity Lua support and Catppuccin.
- `lua/plugins/astrocore.lua`: central options, sessions, filetypes, startup tree/session behavior, and mapping import.
- `lua/mappings.lua`: high-frequency custom keymaps.
- `lua/plugins/*.lua`: local plugin overrides and additions.
- `lazy-lock.json`: pinned plugin revisions. Commit this after intentional `:Lazy update` runs.

## Runtime Profile

`init.lua` sets `vim.g.network_fs` before Lazy loads. Detection uses `vim.uv.fs_statfs()` against the current directory and opened file arguments for Lustre, FUSE/sshfs, NFS, and CIFS/SMB. Override detection when needed:

```bash
NVIM_NETWORK_FS=1 nvim
NVIM_NETWORK_FS=0 nvim
```

Current network filesystem consumers:

- `plugins/snacks.lua`: disables file picker symlink following for the main file picker.
- `plugins/neo-tree.lua`: disables expensive git status, file watchers, gitignore checks, and metadata columns.
- `plugins/performance.lua`: disables selected expensive plugins and defers `smart-splits.nvim` loading.

## UX Choices

- Snacks picker is the active picker. `plugins/telescope.lua` intentionally returns an empty spec.
- Neo-tree is the active file tree. `<leader>d` toggles it; `sf` reveals/focuses the current file.
- Hop provides character jumping through the maintained `smoka7/hop.nvim` fork. `;` starts multi-window character hints in normal mode.
- Smart-splits handles window movement and resizing through `sh`/`sj`/`sk`/`sl` and Ctrl-arrow mappings.
- Buffer tabs use `<leader>;` and `<leader>l` for next/previous, with `<leader>w` to close.
- `render-markdown.nvim` is enabled for Markdown. A `VimLeavePre` guard disables it during teardown to avoid an exit-time scheduled code-block render regression seen after updating the plugin.
- `none-ls.nvim` and `mason-null-ls.nvim` stay disabled; they are not part of this setup.

## Updating Plugins

Use Lazy from inside Neovim:

```vim
:Lazy update
```

After updates, sanity-check Markdown exit behavior because `render-markdown.nvim` has recently regressed there:

```bash
nvim --headless AGENTS.md +'sleep 1000m' +'qa!'
```

Also open `AGENTS.md` interactively and quit once if the update touched `render-markdown.nvim`, Tree-sitter, or UI plugins.

## Local Customization

Keep machine-local behavior out of this directory when possible. Prefer shell-local files such as `~/.profile.local` or environment variables for host-specific behavior, and prefer small plugin specs in `lua/plugins/` for shared Neovim behavior.
