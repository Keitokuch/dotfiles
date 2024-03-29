" ============================ Key Mappings =============================
let mapleader=" "
" jj to exit insert mode
inoremap jj <ESC>
" Use q for escape
map q <ESC>
nnoremap Q q
" Up Down scrolling
nnoremap <C-i> 10k
nnoremap <Tab> 10k
nnoremap <C-d> 10j
vnoremap <C-i> 10k
vnoremap <Tab> 10k
vnoremap <C-d> 10j
" Copy All
nmap <leader>y :%yank *<CR>
" Copy Line
nmap Y y$
" <space>= Indent All
nnoremap <leader>= gg=G<C-o>
" Sudo Write
command Sudow w !sudo dd of=%
command W w !sudo -S tee%
" cmap w!! w !sudo -S tee%

" Split
map s <nop>
map S <nop>
map s_ :set splitbelow<CR>:new<CR>
map s\| :set splitright<CR>:vnew<CR>
map sl <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sp <C-w>p

" Use <Meta-Arrow> or <Space><Arrow> to resize split window
map <M-Up> :resize +5<CR>
map <M-Down> :resize -5<CR>
map <M-Left> :vertical resize-5<CR>
map <M-Right> :vertical resize+5<CR>
map <leader><Up> :resize +5<CR>
map <leader><Down> :resize -5<CR>
map <leader><Left> :vertical resize-5<CR>
map <leader><Right> :vertical resize+5<CR>

"" Tab
" map <leader>t :tabe<CR>
" map <leader>] :+tabnext<CR>
" map <leader>[ :-tabnext<CR>

"" <Space s> to save
map <silent> <leader>s :SaveFile<CR>
"" <Space q> to quit
map <leader>q :qall<CR>
"" <Space Q> to force quit
map <leader>Q :qall!<CR>
"" <Space w> to close file
map <silent> <leader>w :bd!<CR>
"" <Space W> to force close file
map <silent><expr> <leader>W buflisted(bufnr("%"))? ":bp<cr>:bd! #<cr>" : ":q!\<CR>"
"" <Space Ctrl-W> to close window
map <silent> <leader><C-w> :close<CR>
"  <Space n> to create new file
map <leader>n :enew<CR>i
map <silent> <leader>N :NewFile<CR>

"" Jumping
" <Ctrl-P> jump to tag
nnoremap <C-p> <C-]>
" Redo jump
nnoremap <C-u> <C-i>
" jump last tag
nnoremap <C-y> <C-t>

"" Insert mode emacs bindings
inoremap <C-a> <ESC>I
inoremap <C-f> <right>
inoremap <C-b> <left>
inoremap <C-M-b> <ESC>Bi
inoremap <C-M-f> <right><ESC>Wi
inoremap <C-M-d> <right><ESC>WcW
inoremap <silent><expr> <C-e> pumvisible()? "\<C-e>" : "\<ESC>A"
inoremap <silent><expr> <C-p> pumvisible()? "\<C-p>" : "\<up>"
inoremap <silent><expr> <C-n> pumvisible()? "\<C-n>" : "\<down>"

" Minimal auto closing
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''<left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"<left>""
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
