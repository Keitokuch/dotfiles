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
            \ 'visual-multi',
            \ 'colors',
            \ 'colorschemes',
            \ 'syntastic',
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
            \ 'minimap',
            \ 'snazzy',


let g:plugins = has('nvim') ? nvim_plugins + plugins : plugins
call plug#begin()
for plug in plugins
    let f = plug_path . plug . '.vim'
    exec 'source' f
endfor
call plug#end()
