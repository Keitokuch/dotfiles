Plug 'preservim/nerdtree'

let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize = 28
let g:NERDTreeShowHidden = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeMapOpenVSplit = 'so'
let g:NERDTreeMapToggleZoom = 'a'
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

augroup legacy_vim_nerdtree
    autocmd!
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
