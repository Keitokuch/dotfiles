let s:plug_path = g:config_path . 'plugins/'
let s:plugged_dir = get(g:, 'legacy_vim_plugged_dir', expand('~/.vim/plugged'))
let s:plugins = [
            \ 'commentary',
            \ 'easymotion',
            \ 'nerdtree',
            \ 'repeat',
            \ 'surround'
            \]

function! s:missing_plugs() abort
    if !exists('g:plugs')
        return []
    endif

    let l:missing = []
    for [l:name, l:spec] in items(g:plugs)
        if type(l:spec) == type({}) && has_key(l:spec, 'dir') && !isdirectory(l:spec.dir)
            call add(l:missing, l:name)
        endif
    endfor
    return sort(l:missing)
endfunction

function! s:install_missing_plugs() abort
    let l:missing = s:missing_plugs()
    if empty(l:missing)
        return
    endif

    try
        echom 'legacy vim: installing missing plugins: ' . join(l:missing, ', ')
        execute 'PlugInstall --sync ' . join(map(copy(l:missing), 'fnameescape(v:val)'), ' ')
        echom 'legacy vim: plugin install complete; restart Vim if a new mapping is unavailable.'
    catch
        echohl WarningMsg
        echom 'legacy vim: plugin install failed: ' . v:exception
        echohl None
    endtry
endfunction

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

    if get(g:, 'legacy_vim_auto_install_plugins', 1)
        augroup legacy_vim_plug_install
            autocmd!
            autocmd VimEnter * call <SID>install_missing_plugs()
        augroup END
    endif
endif
