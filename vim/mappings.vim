" ============================ Key Mappings =============================
let mapleader=" "
" jj to exit insert mode
inoremap jj <ESC>
" Use q for escape/search clear, matching AstroNvim's normal-mode behavior.
nnoremap <silent> q :nohlsearch<CR><ESC>
vnoremap q <ESC>
nnoremap <silent> <C-c> :nohlsearch<CR><ESC>
vnoremap <C-c> <ESC>
nnoremap Q q
" Up Down scrolling
nnoremap <C-i> 15k
nnoremap <Tab> 15k
nnoremap <C-d> 15j
vnoremap <C-i> 15k
vnoremap <Tab> 15k
vnoremap <C-d> 15j
" Copy All
nmap <leader>y :%yank *<CR>
" Copy Line
nmap Y y$
" <space>= Indent All
nnoremap <leader>= gg=G<C-o>
" Sudo Write
command! Sudow w !sudo dd of=%
command! W w !sudo -S tee % > /dev/null
" cmap w!! w !sudo -S tee%

" Split
nnoremap s <nop>
nnoremap S <nop>
nnoremap s_ :split<CR>
nnoremap s\| :vsplit<CR>
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sk <C-w>k
nnoremap sj <C-w>j
nnoremap sp <C-w>p

" Use Ctrl-arrow like AstroNvim; keep older aliases for terminals that send them.
nnoremap <C-Up> :resize +5<CR>
nnoremap <C-Down> :resize -5<CR>
nnoremap <C-Left> :vertical resize -5<CR>
nnoremap <C-Right> :vertical resize +5<CR>
nnoremap <M-Up> :resize +5<CR>
nnoremap <M-Down> :resize -5<CR>
nnoremap <M-Left> :vertical resize -5<CR>
nnoremap <M-Right> :vertical resize +5<CR>
nnoremap <leader><Up> :resize +5<CR>
nnoremap <leader><Down> :resize -5<CR>
nnoremap <leader><Left> :vertical resize -5<CR>
nnoremap <leader><Right> :vertical resize +5<CR>

"" Tab
" map <leader>t :tabe<CR>
" map <leader>] :+tabnext<CR>
" map <leader>[ :-tabnext<CR>

"" <Space s> to save
nnoremap <silent> <leader>s :SaveFile<CR>
"" <Space q> to quit
nnoremap <leader>q :qall<CR>
"" <Space Q> to force quit
nnoremap <leader>Q :qall!<CR>
"" Buffer navigation/close, matching AstroNvim's high-frequency keys.
nnoremap <silent> <leader>w :CloseBuffer<CR>
nnoremap <silent> <leader>W :ForceCloseBuffer<CR>
nnoremap <silent> <leader>; :<C-u>call NextBuffer(v:count1)<CR>
nnoremap <silent> <leader>l :<C-u>call PreviousBuffer(v:count1)<CR>
"" <Space Ctrl-W> to close window
nnoremap <silent> <leader><C-w> :close<CR>
"  <Space n> to create new file
nnoremap <leader>n :enew<CR>i
nnoremap <silent> <leader>N :NewFile<CR>
"" File explorer: NERDTree when installed, netrw fallback otherwise.
nnoremap <silent> <leader>d :ToggleExplorer<CR>
nnoremap <silent> sf :FocusExplorer<CR>
nnoremap <silent> sF :FindInExplorer<CR>

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
