let g:plug_path = g:config_path . 'plugins/'
let g:plugins = [
            \ 'airline',
            \ 'nerdcommenter',
            \ 'easymotion',
            \ 'interestingwords',
            \ 'nerdtree',
            \ 'tagbar',
            \ 'colorschemes',
            \ 'tags',
            \ 'visual-multi',
            \ 'end_of_plugins'
            \]

let g:nvim_plugins = [
            \ 'scrollbar',
            \ 'vterm',
            \ 'end_of_plugins'
            \]

"""""" Unloaded Plugins
            \ 'leaderf',
            \ 'ctrlsf',
            \ 'indent',
            \ 'colors',
            \ 'devicons',
            \ 'buffet',
            \ 'gitgutter',
            \ 'coc',
            \ 'tabs',
            \ 'pairs',
            \ 'go',
            \ 'polyglot',
            \ 'python',
            \ 'cpp',
            \ 'java',
            \ 'web',
            \ 'vimtex',
            \ 'menubar',
            \ 'scroll',
            \ 'syntastic',
            \ 'minimap',
            \ 'snazzy',


let s:plugins = has('nvim') ? nvim_plugins + plugins : plugins

call plug#begin()
for plug in s:plugins
    let f = plug_path . plug . '.vim'
    if filereadable(f)
        exec 'source' f
    endif
endfor
call plug#end()

for plug in s:plugins
    let f = plug_path . plug . '.after.vim'
    if filereadable(f)
        exec 'source' f
    endif
endfor
