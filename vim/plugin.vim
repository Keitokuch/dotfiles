let s:plug_path = g:config_path . 'plugins/'
let s:plugged_dir = get(g:, 'legacy_vim_plugged_dir', expand('~/.vim/plugged'))
let s:plugins = [
            \ 'commentary',
            \ 'easymotion',
            \ 'nerdtree',
            \ 'repeat',
            \ 'surround'
            \]

let g:legacy_vim_plugins_enabled = 1
try
    call plug#begin(s:plugged_dir)
catch /^Vim\%((\a\+)\)\=:E117/
    let g:legacy_vim_plugins_enabled = 0
endtry

if g:legacy_vim_plugins_enabled
    for plug in s:plugins
        let f = s:plug_path . plug . '.vim'
        if filereadable(f)
            exec 'source ' . fnameescape(f)
        endif
    endfor
    call plug#end()

    for plug in s:plugins
        let f = s:plug_path . plug . '.after.vim'
        if filereadable(f)
            exec 'source ' . fnameescape(f)
        endif
    endfor
endif
