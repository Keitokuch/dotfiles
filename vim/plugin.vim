let g:plug_path = g:config_path . 'plugins/'
let g:plugins = [
            \ 'devicons',
            \ 'gitgutter',
            \ 'airline',
            \ 'coc',
            \ 'cpp',
            \ 'ctrlsf',
            \ 'easymotion',
            \ 'interestingwords',
            \ 'nerdcommenter',
            \ 'nerdtree',
            \ 'polyglot',
            \ 'python',
            \ 'tabs',
            \ 'tagbar',
            \ 'tags',
            \ 'menubar',
            \ 'visual-multi',
            \ 'colors',
            \ 'colorschemes',
            \ 'java',
            \ 'indent',
            \ 'scrollbar',
            \ 'web',
            \ 'vimtex',
            \ 'vterm',
            \ 'leaderf',
            \ 'go',
            \ 'pairs',
            \ 'end_of_plugins'
            \]

let g:nvim_plugins = [
            \ 'end_of_plugins'
            \]

"""""" Unloaded Plugins
            \ 'scroll',
            \ 'buffet',
            \ 'syntastic',
            \ 'minimap',
            \ 'snazzy',


let g:plugins = has('nvim') ? nvim_plugins + plugins : plugins

call plug#begin()
for plug in plugins
    let f = plug_path . plug . '.vim'
    if filereadable(f)
        exec 'source' f
    endif
endfor
call plug#end()

for plug in plugins
    let f = plug_path . plug . '.after.vim'
    if filereadable(f)
        exec 'source' f
    endif
endfor
