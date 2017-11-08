" colibri.vim color theme
" Author: Blaž Hrastnik
"
" Note:

" Bootstrap:

hi clear
if exists("syntax_on") | syntax reset | endif
set background=dark
let g:colors_name = "colibri"

" colibri Colorscheme for GUI

let s:colibri = {}

" foreground #a4a0e8 (non active window)
" lighter foreground #dbbfef (active window)
" #5a5977 neutral window tone
"
let s:colibri.foreground      = ["#a4a0e8", 146]
let s:colibri.background_dark = ["#281733", 17]
let s:colibri.background      = ["#3b224c", 17]
"let s:colibri.background      = ["#311D40", 53] " HSB with B at 25 (instead of 30)
"let s:colibri.background = ["#ffffff", 231]
let s:colibri.background_light = ["#452859", 53]

" ui tones
let s:colibri.disabled = s:colibri.foreground
let s:colibri.active = ["#dbbfef", 183]
let s:colibri.window = s:colibri.background_light
let s:colibri.linenr = ["#5a5977", 60]
let s:colibri.highlight  = ["#00CCCC", 44] " is like a blueish neon 00CCCC
let s:colibri.highlight  = ["#802F00", 88]

" #D7F4A8?
let s:colibri.error     = ["#f47868", 209]
let s:colibri.warning   = ["#ffcd1c", 220]

let s:colibri.builtin  = ["#FFFFFF", 231]
let s:colibri.string   = ["#cccccc", 188]
let s:colibri.proper = ["#FFFFFF", 231]
let s:colibri.constant   = ["#9FF28F", 156] " 81EECF / 7FB998 / 9FF28F! -- 5fe7b7
let s:colibri.bool     = ["#FFFFFF", 231]
let s:colibri.func     = ["#FFFFFF", 231]
let s:colibri.punct    = ["#dbbfef", 183]
"let s:colibri.keyword  = ["#5fe7b7", 79]
"let s:colibri.keyword  = ["#77B56B", 107]
let s:colibri.keyword  = ["#ECCDBA", 223]
let s:colibri.comment  = ["#697C81", 66]
let s:colibri.number   = ["#E8DCA0", 187]

let s:colibri.special  = ["#EFBA5D", 215]

" Diff colors
let s:colibri.diff_green  = ["#35BF86", 1]
let s:colibri.diff_red  = ["#F22C86", 1]
let s:colibri.diff_change = ["#69A0F3", 1]
let s:colibri.dblue   = ["#3B0FBF", 1] " 2CD5F2

"let s:colibri.foreground    = ["#ffffff", 231]
"let s:colibri.builtin  = ["#a4a0e8", 146]
"let s:colibri.proper   = ["#a4a0e8", 146]
"let s:colibri.bool     = ["#a4a0e8", 146]
"let s:colibri.func     = ["#a4a0e8", 146]
" }}}
" Helpers: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  let highlightString = 'hi ' . a:group . ' '

  " Settings for highlight group ctermfg & guifg
  if strlen(a:fg)
    if a:fg == 'fg'
      let highlightString .= 'guifg=fg ctermfg=fg '
    elseif a:fg == 'none'
      let highlightString .= 'guifg=NONE ctermfg=NONE '
    else
      let color = get(s:colibri, a:fg)
      let highlightString .= 'guifg=' . color[0] . ' ctermfg=' . color[1] . ' '
    endif
  endif

  " Settings for highlight group termbg & guibg
  if a:0 >= 1 && strlen(a:1)
    if a:1 == 'bg'
      let highlightString .= 'guibg=bg ctermbg=bg '
    elseif a:1 == 'none'
      let highlightString .= 'guibg=NONE ctermbg=NONE '
    else
      let color = get(s:colibri, a:1)
      let highlightString .= 'guibg=' . color[0] . ' ctermbg=' . color[1] . ' '
    endif
  endif

  " Settings for highlight group cterm & gui
  if a:0 >= 2 && strlen(a:2)
    let highlightString .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
  endif

  " Settings for highlight guisp
  if a:0 >= 3 && strlen(a:3)
    let color = get(s:birds, a:3)
    let highlightString .= 'guisp=#' . color[0] . ' '
  endif

  " echom highlightString

  execute highlightString
endfunction

call s:HL("Normal", 'foreground', 'background', "none")

call s:HL('VertSplit', 'window', 'window', '')

"call s:HL('Cursor',       'background', 'cursor',    'none') " vCursor, iCursor
call s:HL('Visual',       '',           'highlight', 'none')

call s:HL('Search', 'special', 'background_dark', 'inverse')
call s:HL('WildMenu', 'active', 'background', 'inverse')

call s:HL("CursorLine", '', 'window', "none")
call s:HL("CursorColumn", '', 'window', "none")
call s:HL("ColorColumn", '', 'window', "none")

" TODO: Tabline

" - Gutter
call s:HL("LineNr", 'linenr', '', '')
" CursorLineNr
call s:HL('SignColumn',   'active',  'window',      'none')
call s:HL('FoldColumn',   'active',  'window',      'none')
call s:HL('Folded',    'comment',  'background_light',     'none')

" TODO: MatchParen

call s:HL("StatusLine", 'background_dark', 'active', '')
call s:HL("StatusLineNC", 'background_dark', 'disabled', '')

" Directories (netrw, etc.)
call s:HL("Directory", 'keyword', '', "bold")

call s:HL("Title", 'foreground', '', "bold")

call s:HL('ErrorMsg', 'error', 'none', 'bold')
call s:HL('WarningMsg', 'warning', 'none')
call s:HL('MoreMsg', 'diff_green', 'none')
" TODO: ModeMsg, Question

" TODO: Tag

" - Completion menu
call s:HL('Pmenu',    'foreground', 'window', 'none')
"call s:HL('Pmenu',    'active', 'linenr', 'none')
call s:HL('PmenuSel', 'active', 'background_dark', 'none')
call s:HL('PmenuSbar', '', 'background_dark')
call s:HL('PmenuThumb', '', 'active')

" Tildes below buffer
call s:HL('NonText', 'window', '', 'none')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
" TODO: SpecialKey

" - Diffs
call s:HL('DiffAdd', 'diff_green', 'background_light', 'bold')
call s:HL('DiffDelete', 'diff_red', 'background_light', '')
call s:HL('DiffChange', 'foreground', 'dblue', '')
call s:HL('DiffText', 'dblue', 'diff_change', 'bold')

call s:HL('DiffAdded', 'diff_green', '', 'bold')
call s:HL('DiffRemoved', 'diff_red', '', '')
call s:HL('DiffChanged', 'foreground', 'dblue', '')

" --> Syntax
" start simple
call s:HL('Special', 'special', '', 'none')

" next up, comments
call s:HL("Comment", 'comment', '', '')
call s:HL("SpecialComment", 'comment', '', 'reverse')
call s:HL("Todo", 'warning', "window", "italic")
call s:HL('Error', 'error', 'window')

" -> Keywords
" generic statement
call s:HL("Statement", 'keyword', '', '')
" if, then, else, endif, switch, etc.
call s:HL("Conditional", 'keyword', '', '')
" sizeof, "+", "*", etc.
call s:HL("Operator", 'punct', '', '')
" Repeat (for, do, while, etc.)
call s:HL("Repeat", 'keyword', '', '')
" try, catch, throw
" Exception
" any other keyword
call s:HL("Keyword", 'keyword', '', '')

" Functions and variable declarations
call s:HL("Identifier", 'builtin', '', '')
call s:HL("Function", 'func', '', '')

" Preprocessor
call s:HL("PreProc", 'punct', '', '')
" Include
call s:HL("Define", 'keyword', '', '')
" Macro, PreCondit

" Constants
call s:HL("Constant", 'constant', '', '')
" character constant: 'c', '/n'
" Character
call s:HL("Boolean", 'bool', '', '')
call s:HL("Number", 'number', '', '')
call s:HL("Float", 'number', '', '')
call s:HL("String", 'string', '', '')

" --> Types
" generic
call s:HL("Type", 'proper', '', '')
" static, register, volatile, etc
" StorageClass
" struct, union, enum, etc.
call s:HL("Structure", 'proper', '', '')
" Typedef

" --> Language specifics

" Ruby
call s:HL("rubySymbol", 'punct', '', '')
" apparently not the same as constant? (module/class name)
call s:HL("rubyConstant", 'proper', '', '')
call s:HL("rubyStringDelimiter", 'string', '', 'italic')
call s:HL("rubyIdentifier", 'proper', '', '')

call s:HL("rubyRailsMethod", 'proper', '', '')

" Elixir
call s:HL('elixirStringDelimiter',        'string', '', 'italic')
call s:HL('elixirInterpolationDelimiter', 'punct',   '', '')

" HTML
call s:HL("htmlTag",     'keyword', '', '')
call s:HL("htmlEndTag",  'keyword', '', '')
call s:HL("htmlTagName", 'keyword', '', '')
call s:HL("htmlArg",     'func', '', '')

" Markdown
call s:HL("htmlH1",     'punct', '', '')

" YAJS
call s:HL("javascriptImport", 'keyword', '', '')
call s:HL('javascriptExport', 'keyword', '', '')
call s:HL("javascriptIdentifier", 'proper', '', '')
call s:HL("javascriptIdentifierName", 'proper', '', '')
call s:HL("javascriptObjectLabel", 'punct', '', '')
" javascriptBraces
" typescriptBraces
"call s:HL('javascriptEndColons', 'foreground',  '', '')
"call s:HL('typescriptEndColons', 'foreground',  '', '')

" YAML

" CSS
hi link cssVendor cssDefinition
call s:HL("cssAttrComma", 'punct', '', '')

" ALE integration
call s:HL('ALEWarningSign', 'warning', '')
call s:HL('ALEErrorSign', 'error', '')
