"
"  vim colorscheme
"  vim-keitoku.vim
"  author: JC
"

set background=dark
highlight clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="vim-keitoku"
let colors_name="vim-keitoku"
" let s:black       = { "gui": "#1c2833", "cterm": "234" } "opaque
" let s:black       = { "gui": "#162025", "cterm": "234" } "green
let s:black         = { "gui": "#141e26", "cterm": "234" } "blue
let s:white         = { "gui": "#e0e3e3", "cterm": "188" }
let s:white0        = { "gui": "#ffffff", "cterm": "188" }
let s:red           = { "gui": "#e06c75", "cterm": "168" }

let s:lightblue     = { "gui": "#4faadd", "cterm": "12"  }
let s:blue          = { "gui": "#5ea6ed", "cterm": "75"  }
let s:greyblue      = { "gui": "#6699cc", "cterm": "39"  }
let s:darkblue      = { "gui": "#1d87b8", "cterm": "39"  }

let s:lightcyan     = { "gui": "#80d4ff", "cterm": "12" }
let s:cyan          = { "gui": "#5ccfe6", "cterm": "81"  }
let s:darkcyan      = { "gui": "#5fb3b3", "cterm": "74"  }

let s:greyviolet    = { "gui": "#556Aff", "cterm": "99" }
let s:violet        = { "gui": "#d787d7", "cterm": "169" }
let s:darkviolet    = { "gui": "#c594c5", "cterm": "141" }

let s:brightorange  = { "gui": "#ffa091", "cterm": "168" }
let s:orange        = { "gui": "#f99157", "cterm": "208" }
let s:coral         = { "gui": "#e6a58a", "cterm": "138" }
let s:rose          = { "gui": "#F48FA8", "cterm": "206" }

let s:lightyellow   = { "gui": "#f2e361", "cterm": "226" }
let s:yellow        = { "gui": "#ffd073", "cterm": "220" }

let s:darkbrown     = { "gui": "#d48a99", "cterm": "142" }

let s:brightgreen   = { "gui": "#dbff33", "cterm": "190" }
let s:green         = { "gui": "#bae67e", "cterm": "149" }
let s:darkgreen     = { "gui": "#98c379", "cterm": "114" }

let s:navy          = { "gui": "#1b3e5e", "cterm": "237" }
let s:lightnavy     = { "gui": "#2b5e7e", "cterm": "237" }

let s:lightgrey     = { "gui": "#919baa", "cterm": "247" }
let s:grey          = { "gui": "#5c6370", "cterm": "241" }
let s:darkgrey      = { "gui": "#313640", "cterm": "237" }
let s:grey1         = { "gui": "#474e5d", "cterm": "239" }
let s:black1        = { "gui": "#282c34", "cterm": "236" }

let s:gutter_fg     = s:lightgrey
let s:gutter_bg     = s:black1
let s:selection     = s:grey1

let s:fg            = s:white
let s:bg            = s:black
let s:comment_fg    = s:grey
let s:cursor_line   = s:navy

function! s:hi(group, fg, bg, attr)
    let hi_str = "hi " . a:group
    if !empty(a:fg)
        let hi_str .= " guifg=" . a:fg.gui . " ctermfg=" . a:fg.cterm
    else
        let hi_str .= " guifg=NONE cterm=NONE"
    endif
    if !empty(a:bg)
        let hi_str .= " guibg=" . a:bg.gui . " ctermbg=" .a:bg.cterm
    else
        let hi_str .= " guibg=NONE ctermbg=NONE"
    endif
    if a:attr != ""
        let hi_str .= " gui=" . a:attr . " cterm=" . a:attr
    else
        let hi_str .= " gui=NONE cterm=NONE"
    endif
    exec hi_str
endfunction


" User interface colors
call s:hi("Normal", s:fg, s:bg, "")
call s:hi("NonText", s:fg, {}, "")

call s:hi("Cursor", s:bg, s:blue, "")
call s:hi("CursorColumn", {}, s:cursor_line, "")
call s:hi("CursorLine", {}, s:cursor_line, "")

call s:hi("LineNr", s:gutter_fg, s:gutter_bg, "")
call s:hi("CursorLineNr", s:fg, {}, "")

call s:hi("DiffAdd", s:blue, {}, "")
call s:hi("DiffChange", s:yellow, {}, "")
call s:hi("DiffDelete", s:red, {}, "")
call s:hi("DiffText", s:green, {}, "")

call s:hi("IncSearch", s:bg, s:yellow, "")
call s:hi("Search", s:bg, s:yellow, "")

call s:hi("ErrorMsg", s:fg, {}, "")
call s:hi("ModeMsg", s:fg, {}, "")
call s:hi("MoreMsg", s:fg, {}, "")
call s:hi("WarningMsg", s:red, {}, "")
call s:hi("Question", s:violet, {}, "")

call s:hi("Pmenu", s:bg, s:fg, "")
call s:hi("PmenuSel", s:fg, s:blue, "")
call s:hi("PmenuSbar", {}, s:selection, "")
call s:hi("PmenuThumb", {}, s:fg, "")

call s:hi("SpellBad", s:red, {}, "")
call s:hi("SpellCap", s:yellow, {}, "")
call s:hi("SpellLocal", s:yellow, {}, "")
call s:hi("SpellRare", s:yellow, {}, "")

call s:hi("StatusLine", s:blue, s:cursor_line, "")
call s:hi("StatusLineNC", s:comment_fg, s:cursor_line, "")
call s:hi("TabLine", s:fg, s:darkgrey, "")
call s:hi("TabLineFill", s:fg, s:bg, "")
call s:hi("TabLineSel", s:darkgrey, s:bg, "")
call s:hi("TabAlt", s:darkgreen, s:bg, "")
call s:hi("Block", s:bg, s:green, "")


call s:hi("Visual", {}, s:selection, "")
call s:hi("VisualNOS", {}, s:selection, "")

call s:hi("ColorColumn", {}, s:darkgrey, "")
call s:hi("Conceal", s:fg, {}, "")
call s:hi("Directory", s:blue, {}, "")
call s:hi("VertSplit", s:darkgrey, s:darkgrey, "")
call s:hi("Folded", s:fg, {}, "")
call s:hi("FoldColumn", s:fg, {}, "")
call s:hi("SignColumn", s:fg, {}, "")

call s:hi("MatchParen", s:blue, {}, "underline")
call s:hi("SpecialKey", s:fg, {}, "")
call s:hi("Title", s:green, {}, "")
call s:hi("WildMenu", s:fg, {}, "")

" Syntax colors

call s:hi("Constant", s:green, {}, "")
call s:hi("String", s:green, {}, "")
call s:hi("Character", s:green, {}, "")
call s:hi("Number", s:lightcyan, {}, "")
call s:hi("Boolean", s:orange, {}, "")
call s:hi("Float", s:lightcyan, {}, "")

call s:hi("Identifier", s:yellow, {}, "")
call s:hi("Function", s:blue, {}, "")

call s:hi("Statement", s:violet, {}, "")
call s:hi("Conditional", s:orange, {}, "")
call s:hi("Repeat", s:orange, {}, "")
call s:hi("Label", s:violet, {}, "")
call s:hi("Operator", s:darkcyan, {}, "")
call s:hi("Keyword", s:orange, {}, "")
call s:hi("Exception", s:red, {}, "")

call s:hi("PreProc", s:brightorange, {}, "")
call s:hi("Include", s:brightorange, {}, "")
call s:hi("Define", s:red, {}, "")
call s:hi("Macro", s:red, {}, "")
call s:hi("PreCondit", s:brightorange, {}, "")

call s:hi("Type", s:lightcyan, {}, "")
call s:hi("StorageClass", s:darkviolet, {}, "")
call s:hi("Structure", s:lightcyan, {}, "")
call s:hi("Typedef", s:yellow, {}, "")

call s:hi("Conventional", s:darkcyan, {}, "italic")
call s:hi("FunctionCall", s:lightblue, {}, "")
call s:hi("FunctionDeclaration", s:cyan, {}, "")
call s:hi("BuiltinFunc", s:cyan, {}, "")

call s:hi("Special", s:red, {}, "")
call s:hi("SpecialChar", s:darkcyan, {}, "")
call s:hi("Tag", s:fg, {}, "")
call s:hi("Delimiter", s:fg, {}, "")
call s:hi("SpecialComment", s:fg, {}, "")
call s:hi("Debug", s:fg, {}, "")

call s:hi("Underlined", s:fg, {}, "")
call s:hi("Ignore", s:fg, {}, "")
call s:hi("Error", s:red, s:gutter_bg, "")
call s:hi("Todo", s:yellow, s:darkgrey, "")

call s:hi("PreProc", s:yellow, {}, "")
call s:hi("SpecialComment", s:comment_fg, {}, "italic")
call s:hi("Comment", s:comment_fg, {}, "italic")

call s:hi("javaDocTags", s:comment_fg, {}, "underline,italic")

" https://github.com/romgrk/barbar.nvim
let s:cb_fg = s:white
let s:cb_bg = s:lightnavy
let s:mb_fg = s:rose
call s:hi("BufferCurrent", s:cb_fg, s:cb_bg, "")
call s:hi("BufferCurrentIndex", s:cb_fg, s:cb_bg, "")
call s:hi("BufferCurrentMod", s:mb_fg, s:cb_bg, "")
call s:hi("BufferCurrentSign", s:rose, s:cb_bg, "")
call s:hi("BufferCurrentTarget", s:red, s:cb_bg, "")
let s:ib_fg = s:lightgrey
let s:ib_bg = s:bg
call s:hi("BufferInactive", s:ib_fg, s:ib_bg, "")
call s:hi("BufferInactiveIndex", s:ib_fg, s:ib_bg, "")
call s:hi("BufferInactiveMod", s:ib_fg, s:ib_bg, "")
call s:hi("BufferInactiveSign", s:ib_fg, s:ib_bg, "")
call s:hi("BufferInactiveTarget", s:red, s:ib_bg, "")
let s:vb_fg = s:fg
let s:vb_bg = s:darkgrey
call s:hi("BufferVisible", s:vb_fg, s:vb_bg, "")
call s:hi("BufferVisibleIndex", s:vb_fg, s:vb_bg, "")
call s:hi("BufferVisibleMod", s:vb_fg, s:vb_bg, "")
call s:hi("BufferVisibleSign", s:vb_fg, s:vb_bg, "")
