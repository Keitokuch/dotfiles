" ================== Utils ===================
" Syntax Stack
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <C-g> :call <SID>SynStack()<CR>

function! s:ListedBuffers()
    return filter(range(1, bufnr('$')), 'buflisted(v:val)')
endfunction

function! LegacyBufferTabline()
    let l:line = ''
    let l:buffers = s:ListedBuffers()
    if empty(l:buffers)
        return '%#TabLineFill#%T'
    endif
    for l:index in range(0, len(l:buffers) - 1)
        let l:bufnr = l:buffers[l:index]
        let l:name = bufname(l:bufnr)
        let l:label = fnamemodify(l:name, ':t')
        if empty(l:label)
            let l:label = empty(l:name) ? '[No Name]' : fnamemodify(l:name, ':~:.')
        endif
        let l:label .= getbufvar(l:bufnr, '&modified') ? '+' : ''
        let l:line .= '%' . l:bufnr . 'T'
        let l:line .= l:bufnr == bufnr('%') ? '%#TabLineSel#' : '%#TabLine#'
        let l:line .= ' ' . (l:index + 1) . ':' . l:label . ' '
    endfor
    return l:line . '%#TabLineFill#%T'
endfunction
set tabline=%!LegacyBufferTabline()

function! s:GoToListedBuffer(offset)
    let l:buffers = s:ListedBuffers()
    if empty(l:buffers)
        return
    endif
    let l:index = index(l:buffers, bufnr('%'))
    let l:index = l:index < 0 ? 0 : l:index
    let l:target = l:buffers[(l:index + a:offset) % len(l:buffers)]
    execute 'buffer ' . l:target
endfunction

function! NextBuffer(count)
    call s:GoToListedBuffer(a:count > 0 ? a:count : 1)
endfunction
command! -count=1 NextBuffer call NextBuffer(<count>)

function! PreviousBuffer(count)
    call s:GoToListedBuffer(-(a:count > 0 ? a:count : 1))
endfunction
command! -count=1 PreviousBuffer call PreviousBuffer(<count>)

function! s:OpenExplorer(dir)
    if exists(':NERDTree') == 2
        exe 'NERDTree ' . fnameescape(a:dir)
        silent! wincmd p
    elseif exists(':Lexplore') == 2
        exe 'Lexplore ' . fnameescape(a:dir)
        silent! wincmd p
    elseif exists(':Explore') == 2
        exe 'Explore ' . fnameescape(a:dir)
    endif
endfunction

fu! StartSetup()
    if (argc() == 0 && !get(g:, 'legacy_vim_using_stdin', 0))
        let g:DIR_START = 1
        let g:START_DIR = getcwd()
        if !RestoreSess()
            call s:OpenExplorer(g:START_DIR)
        endif
    elseif argc() == 1 && isdirectory(argv()[0]) == 1 && !get(g:, 'legacy_vim_using_stdin', 0)
        let g:DIR_START = 1
        exe 'cd ' . fnameescape(argv()[0])
        let g:START_DIR = getcwd()
        if !RestoreSess()
            call s:OpenExplorer(g:START_DIR)
            silent! enew
        endif
        exe '%argd'
    else
        let g:DIR_START=0
    endif
endfu

let s:session_file_suffix = has('nvim') ? '.Session.nvim' : '.Session.vim'
let s:session_dir = expand('~/.vim/sessions')
call mkdir(s:session_dir, 'p')

fu! s:session_file_path()
    let l:session_name = substitute(g:START_DIR, '[\/:]', '_', 'g')
    let l:session_name = empty(l:session_name) ? 'root' : l:session_name
    let l:file = l:session_name . s:session_file_suffix
    let l:session_file_path = s:session_dir . '/' . l:file
    return l:session_file_path
endfu

fu! RestoreSess()
    let l:session_file = s:session_file_path()
    if filereadable(l:session_file)
        exe 'source ' . fnameescape(l:session_file)
        " if bufexists(1)
        "     for l in range(1, bufnr('$'))
        "         if bufwinnr(l) == -1
        "             exe 'sbuffer ' . l
        "         endif
        "     endfor
        " else
        "     exe 'Explore' | wincmd p
        " endif
        return 1
    else
        return 0
    endif
endfunction

fu! LeaveSetup()
    let currTab = tabpagenr()
    tabdo helpclose
    if exists('g:loaded_nerd_tree')
        tabdo silent! NERDTreeClose
    endif
    exe 'tabn ' . currTab
    if exists('g:DIR_START') && g:DIR_START
        let l:session_file = s:session_file_path()
        exe 'mksession! ' . fnameescape(l:session_file)
    endif
endfu

function! ToggleExplorer()
    if exists(':NERDTreeToggle') == 2
        NERDTreeToggle
    elseif exists(':Lexplore') == 2
        Lexplore
    elseif exists(':Explore') == 2
        Explore
    endif
endfunction
command! -nargs=0 ToggleExplorer call ToggleExplorer()

function! FocusExplorer()
    if exists('b:NERDTree')
        wincmd p
    elseif exists(':NERDTreeFind') == 2 && expand('%') != ''
        NERDTreeFind
    elseif exists(':NERDTreeFocus') == 2
        NERDTreeFocus
    elseif exists(':Lexplore') == 2
        Lexplore
    elseif exists(':Explore') == 2
        Explore
    endif
endfunction
command! -nargs=0 FocusExplorer call FocusExplorer()

function! FindInExplorer()
    if exists(':NERDTreeFind') == 2 && expand('%') != ''
        NERDTreeFind
    elseif exists(':Explore') == 2
        Explore
    endif
endfunction
command! -nargs=0 FindInExplorer call FindInExplorer()

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
command! -nargs=0 CloseBuffer call CloseBuffer()

function! ForceCloseBuffer()
    let l:bufnr = bufnr('%')
    if buflisted(l:bufnr)
        if len(s:ListedBuffers()) == 1
            enew
        else
            call PreviousBuffer(1)
        endif
        execute 'bdelete! ' . l:bufnr
    else
        q!
    endif
endfunction
command! -nargs=0 ForceCloseBuffer call ForceCloseBuffer()

function! SaveFile()
    if bufname("%") != ""
        write
    else
        let currentpath = getcwd()
        let filename = input("Save as: ", currentpath."/")
        exe "write " . fnameescape(filename)
    endif
endfu
command! -nargs=0 SaveFile call SaveFile()

function! NewFile()
    let currentpath = getcwd()
    let filename = input("New File: ", currentpath. "/")
    exe "edit " . fnameescape(filename)
endfu
command! -nargs=0 NewFile call NewFile()
