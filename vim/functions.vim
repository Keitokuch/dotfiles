" ================== Utils ===================
" Syntax Stack
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <C-g> :call <SID>SynStack()<CR>

fu! StartSetup()
    if (argc() == 0 && !exists("s:std_in"))
        let g:DIR_START = 1
        let g:START_DIR = getcwd()
        if !RestoreSess()
            exe 'NERDTreeToggle'
        endif
    elseif argc() == 1 && isdirectory(argv()[0]) == 1 && !exists("s:std_in")
        let g:DIR_START = 1
        exe 'cd ' . argv()[0]
        let g:START_DIR = getcwd()
        if !RestoreSess()
            exe 'NERDTreeToggle' g:START_DIR | wincmd p | enew
        endif
        exe '%argd'
    else
        let g:DIR_START=0
    endif
endfu

let s:session_file_suffix = has('nvim') ? '.Session.nvim' : '.Session.vim'
let s:session_dir = g:config_path . 'sessions'
call mkdir(s:session_dir, 'p')

fu! s:session_file_path()
    let l:session_name = substitute(g:START_DIR, "/", "", "")
    let l:session_name = substitute(l:session_name, "/", "_", "g")
    let l:file = l:session_name . s:session_file_suffix
    let l:session_file_path = s:session_dir . '/' . l:file
    return l:session_file_path
endfu

fu! RestoreSess()
    let l:session_file = s:session_file_path()
    echo l:session_file
    if filereadable(l:session_file)
        exe 'so ' . l:session_file
        " if bufexists(1)
        "     for l in range(1, bufnr('$'))
        "         if bufwinnr(l) == -1
        "             exe 'sbuffer ' . l
        "         endif
        "     endfor
        " else
        "     exe 'NERDTreeFind' | wincmd p
        " endif
        return 1
    else
        return 0
    endif
endfunction

fu! LeaveSetup()
    let currTab = tabpagenr()
    let restore_tree = g:NERDTree.IsOpen() ? 1 : 0
    tabdo helpclose
    if exists('g:loaded_nerd_tree') | tabdo NERDTreeClose
    endif
    if exists('g:loaded_vterm') | tabdo VTermClose
    endif
    if exists('g:loaded_tagbar') | tabdo TagbarClose
    endif
    exe 'tabn ' . currTab
    if g:DIR_START
        let l:session_file = s:session_file_path()
        exe 'mksession! ' . l:session_file
        if restore_tree
            call writefile(["NERDTreeToggle | wincmd p"], l:session_file, "a")
        endif
    endif
endfu

function! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
command -nargs=0 StripTrailingSpaces call StripTrailingWhitespaces()

function! CloseBuffer()
    if buflisted(bufnr("%"))
        if &modified
            echo "Changes Not Saved!"
        elseif len(getbufinfo({'buflisted':1})) == 1
            enew
            bd #
        else
            bp
            bd #
        endif
    else
        q
    endif
endfu
command! -n=0 CloseBuffer call CloseBuffer()

function! SaveFile()
    if bufname("%") != ""
        write 
    else
        let currentpath = getcwd()
        let filename = input("Save as: ", currentpath."/")
        exe "write " . filename
    endif
endfu
command! -n=0 SaveFile call SaveFile()

function! NewFile()
    let currentpath = getcwd()
    let filename = input("New File: ", currentpath. "/")
    exe "edit " . filename
endfu
command! -n=0 NewFile call NewFile()
