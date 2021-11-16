Plug 'ludovicchabant/vim-gutentags'

" ------------------------------------ vim-gutentags ----------------------------------
augroup statusline
    " this one is which you're most likely to use?
    autocmd VimEnter set statusline+=%{gutentags#statusline()}
augroup end
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project', '.proj']
" let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_cache_dir = expand('~/.cache/tags/')

let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ 'dist',
      \ 'bin',
      \ '.ccls',
      \ '.ccls-*',
      \ 'node_modules',
      \ 'cache',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '*.json',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \]
