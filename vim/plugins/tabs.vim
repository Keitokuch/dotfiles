Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.icons = 'both'
let bufferline.icon_custom_colors = v:false
let bufferline.closable = v:false
let bufferline.maximum_padding = 2

" Move to previous/next
nnoremap <silent>    <leader>l :BufferPrevious<CR>
nnoremap <silent>    <leader>; :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <leader>< :BufferMovePrevious<CR>
nnoremap <silent>    <leader>> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <leader>1 :BufferGoto 1<CR>
nnoremap <silent>    <leader>2 :BufferGoto 2<CR>
nnoremap <silent>    <leader>3 :BufferGoto 3<CR>
nnoremap <silent>    <leader>4 :BufferGoto 4<CR>
nnoremap <silent>    <leader>5 :BufferGoto 5<CR>
nnoremap <silent>    <leader>6 :BufferGoto 6<CR>
nnoremap <silent>    <leader>7 :BufferGoto 7<CR>
nnoremap <silent>    <leader>8 :BufferGoto 8<CR>
nnoremap <silent>    <leader>9 :BufferLast<CR>
" Close buffer
" nnoremap <silent>    <leader>w :BufferClose<CR>

function! MyTabline()
    let tabline=&tabline
    if g:NERDTree.IsOpen()
        let width = winwidth(g:NERDTree.GetWinNum())
        let tabline = '%#Normal#' . repeat(' ', width) . '%#VertSplit# ' . tabline
    endif
    return tabline
endfunction

" au VimEnter * set tabline=%!MyTabline()
function! CloseBuffer()
    if buflisted(bufnr("%"))
        if &modified
            echo "Changes Not Saved!"
        elseif len(getbufinfo({'buflisted':1})) == 1
            BufferClose
            enew
        else
            BufferClose
        endif
    else
        q
    endif
endfu
command! -n=0 CloseBuffer call CloseBuffer()
