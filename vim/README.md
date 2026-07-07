# Legacy Vim Fallback

This directory is the Vim fallback config. Neovim uses `astronvim/v5/`; do not add a second Neovim path here.

## Deploy

Deploy with:

```bash
./do_deploy.sh vim
```

The deploy links `vim/init.vim` to `~/.vim/vimrc`, links this directory into `~/.vim/`, and links themes into `~/.vim/colors/`.

After deploy, `deploy/vim.deploy.after` installs vim-plug to `~/.vim/autoload/plug.vim` if it is missing:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Plugin checkout installation is still explicit:

```vim
:PlugInstall
```

## Plugins

Keep this set small so plain Vim remains a reliable editor when Neovim is unavailable.

- `vim-commentary`: `gc`/`gcc` comments and `<leader>/` compatibility.
- `vim-easymotion`: `;` character-hint cursor jumping, matching the AstroNvim Hop workflow.
- `preservim/nerdtree`: file tree sidebar, with netrw as fallback if plugins are absent.
- `vim-repeat`: repeat support for compatible plugin mappings.
- `vim-surround`: surround editing, including `S` muscle memory.

The config starts without vim-plug or installed plugins. Missing plugin loading is skipped, and automatic plugin installation is disabled unless `g:legacy_vim_auto_install_plugins` is set.

## AstroNvim-Aligned Keys

- `<leader>s`: save.
- `<leader>q` / `<leader>Q`: quit / force quit.
- `<leader>w` / `<leader>W`: close buffer / force close buffer.
- `<leader>;` / `<leader>l`: next / previous buffer.
- `<leader>d`: toggle file tree.
- `sf`: focus or reveal the current file in the tree.
- `s|` / `s_`: vertical / horizontal split of the current buffer.
- `sh` / `sj` / `sk` / `sl`: move between windows.
- Ctrl-arrow: resize windows.
- `<C-d>` / `<C-i>` / `<Tab>`: move 15 lines.
- `;`: character-hint cursor jump.

The buffer tabline, statusline, line numbers, relative numbers, cursorline, signcolumn, mouse support, and clipboard setting are configured to keep the basic editing feel close to AstroNvim without adding heavy dependencies.
