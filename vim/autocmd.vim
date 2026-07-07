"  Vim autocmds
"
autocmd StdinReadPre * let g:legacy_vim_using_stdin = 1

" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if get(g:, 'legacy_vim_auto_install_plugins', 0) && exists('g:legacy_vim_plugins_enabled') && g:legacy_vim_plugins_enabled && exists('g:plugs') && exists(':PlugInstall') == 2 && len(filter(copy(values(g:plugs)), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif

" Set and clear cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Hori split help window
autocmd BufWinEnter * if &buftype == "help" | wincmd L | vert resize 80 | endif

"" ====================== Additional Features ========================
" Start from last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup startup
    " Automatically Save and Restore Session
    autocmd VimEnter * nested call StartSetup()
    autocmd VimLeave * call LeaveSetup()
augroup end

" Unlist filetypes
augroup unlistbuf
    au Filetype rst set nobuflisted     " do not list python doc files
    au Filetype log set nobuflisted     " do not list log files
augroup end

" Remove empty buffers
au BufWinLeave * if bufname("%") == "" && line('$') == 1 && getline(1) == ''| set nobuflisted | endif

" Trim whitespaces on save
" au BufWrite * StripTrailingSpaces
