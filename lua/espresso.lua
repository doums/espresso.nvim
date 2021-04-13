--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local o = vim.o

local function log(msg, hi)
  if hi then cmd(string.format('echohl %s', hi)) end
  cmd(string.format('echom "[espresso] %s"', msg))
  if hi then cmd 'echohl None' end
end

if fn.has('termguicolors') ~= 1 or not o.termguicolors then
  log('needs truecolor to work (see :h termguicolors).', 'Error')
  return
end

-- stuff for the legacy regex engine
cmd 'highlight clear'
if fn.exists('syntax_on') == 1 then
  cmd 'syntax reset'
end

g.colors_name = 'espresso'

-- the palette
local p = {
  bg = '#2A211C',
  fg = '#BDAE9D',
  cursor = '#889AFF',
  identifierUnderCaret = '#3C3C57',
  identifierUnderCaretWrite = '#472C47',
  gutter = '#2A211C',
  selection = '#95B8FA',
  cursorLine = '#3A312C',
  cursorLineNr = '#A4A3A3',
  errorMsg = '#CC666E',
  error = '#BC3F3C',
  warning = '#4A3F10',
  muted = '#BFBFBF',
  link = '#C7C7FF',
  stdOutput = '#E4E4FF',
  lineNumber = '#BDAE9D',
  matchBrace = '#3A6DA0',
  todo = '#C7C7FF',
  search = '#5F5F00',
  incSearch = '#4F4F82',
  foldedFg = '#8C8C8C',
  foldedBg = '#3A3A3A',
  constant = '#C5656B',
  keyword = '#43A8ED',
  comment = '#0066FF',
  string = '#049B0A',
  number = '#44AA43',
  commentTag = '#8A653B',
  ['function'] = '#FF9358',
  diffAdd = '#294436',
  diffText = '#385570',
  diffDelete = '#484A4A',
  diffChange = '#303C47',
  addStripe = '#384C38',
  whitespaceStripe = '#4C4638',
  changeStripe = '#374752',
  deleteStripe = '#656E76',
  typo = '#659C6B',
  metaData = '#43A8ED',
  macroName = '#908B25',
  cDataStructure = '#B5B6E3',
  debug = '#666D75',
  errorStripe = '#FF0000',
  warnStripe = '#FFFF00',
  infoStripe = '#FFFFCC',
  hintStripe = '#9E9E80',
  menu = '#46484A',
  menuFg = '#BBBBBB',
  menuSel = '#113A5C',
  menuSBar = '#616263',
  statusLine = '#3C3F41',
  statusLineFg = '#BBBBBB',
  statusLineNC = '#787878',
  tabLineSel = '#4E5254',
  duplicateFromServer = '#30322B',
  hintBg = '#3B3B3B',
  hintFg = '#787878',
  wrapGuide = '#4D4D4D',
  UIBorder = '#616161',
  UISelection = '#0D293E',
  ANSIBlack = '#FFFFFF',
  ANSIRed = '#FF6767',
  ANSIGreen = '#68E868',
  ANSIYellow = '#754200',
  ANSIBlue = '#C7C7FF',
  ANSIMagenta = '#FF2EFF',
  ANSICyan = '#06B8B8',
  ANSIGray = '#A7A7A7',
  ANSIDarkGray = '#555555',
  ANSIBrightRed = '#FF8785',
  ANSIBrightGreen = '#A8C023',
  ANSIBrightYellow = '#FFFF00',
  ANSIBrightBlue = '#7EAEF1',
  ANSIBrightMagenta = '#FF99FF',
  ANSIBrightCyan = '#6CDADA',
  ANSIWhite = '#1F1F1F',
  UIBlue = '#3592C4',
  UIGreen = '#499C54',
  UIRed = '#C75450',
  UIBrown = '#93896C'
}

local function hi(name, foreground, background, style)
  local fg = 'guifg='..(foreground or 'NONE')
  local bg = 'guibg='..(background or 'NONE')
  local decoration = 'gui='..(style or 'NONE')
  local hi_command = string.format('hi %s %s %s %s', name, fg, bg, decoration)
  cmd(hi_command)
end

local function li(target, source)
  cmd(string.format('hi! link %s %s', target, source))
end

-- helper groups
hi('Warning', nil, p.warning)
hi('Hint', p.hintFg, p.hintBg)

-- builtin groups `:h highlight-groups`
hi('ColorColumn', nil, p.wrapGuide)
hi('Conceal', p.muted, p.bg)
hi('Cursor', p.cursor)
li('lCursor', 'Cursor')
li('CursorIM', 'Cursor')
li('CursorColumn', 'CursorLine')
hi('CursorLine', nil, p.cursorLine, 'NONE')
li('Directory', 'NormalFg')
hi('DiffAdd', nil, p.diffAdd)
hi('DiffChange', nil, p.diffChange)
hi('DiffDelete', nil, p.diffDelete)
hi('DiffText', nil, p.diffText)
li('EndOfBuffer', 'NonText')
-- TermCursor
-- TermCursorNC
hi('ErrorMsg', p.errorMsg)
hi('VertSplit', p.muted)
hi('Folded', p.foldedFg, p.foldedBg)
li('FoldColumn', 'Folded')
hi('SignColumn', nil, p.gutter)
hi('IncSearch', nil, p.incSearch)
li('Substitute', 'Search')
hi('LineNr', p.lineNumber, p.gutter)
hi('CursorLineNr', p.constant, p.bg, 'bold')
hi('MatchParen', nil, p.matchBrace)
hi('ModeMsg', p.stdOutput)
li('MsgArea', 'NormalFg')
li('MsgSeparator', 'StatusLine')
li('MoreMsg', 'NormalFg')
hi('NonText', p.muted)
hi('Normal', p.fg, p.bg)
li('NormalFloat', 'Pmenu')
li('NormalNC', 'NormalFg')
hi('Pmenu', p.menuFg, p.menu)
hi('PmenuSel', p.menuFg, p.menuSel)
hi('PmenuSbar', p.menu, p.menu)
hi('PmenuThumb', p.menuSBar, p.menuSBar)
li('Question', 'NormalFg')
li('QuickFixLine', 'NormalFg')
hi('Search', nil, p.search)
li('SpecialKey', 'NonText')
hi('SpellBad', p.typo, nil, 'underline')
li('SpellCap', 'SpellBad')
li('SpellLocal', 'SpellBad')
li('SpellRare', 'SpellBad')
hi('StatusLine', p.statusLineFg, p.statusLine)
hi('StatusLineNC', p.statusLineNC, p.statusLine)
hi('TabLine', p.statusLineFg, p.statusLine)
hi('TabLineFill', p.statusLine, p.statusLine)
hi('TabLineSel', p.fg, p.tabLineSel)
li('Title', 'Special')
hi('Visual', nil, p.selection)
li('VisualNOS', 'Visual')
li('WarningMsg', 'Warning')
li('Whitespace', 'NonText')
li('WildMenu', 'PmenuSel')

-- common groups `:h group-name`
hi('Comment', p.comment, nil, 'italic')
hi('Constant', p.constant, nil, 'bold')
hi('String', p.string)
li('Character', 'String')
hi('Number', p.number)
li('Boolean', 'Keyword')
li('Float', 'Number')
li('Identifier', 'NormalFg')
hi('Function', p['function'], nil, 'bold')
li('Statement', 'Keyword')
li('Conditional', 'Keyword')
li('Repeat', 'Keyword')
li('Label', 'Keyword')
li('Operator', 'Keyword')
hi('Keyword', p.keyword, nil, 'bold')
li('Exception', 'Keyword')
hi('PreProc', p.metaData)
li('Include', 'PreProc')
li('Define', 'PreProc')
li('Macro', 'PreProc')
li('PreCondit', 'PreProc')
li('Type', 'Keyword')
li('StorageClass', 'Keyword')
li('Structure', 'Keyword')
li('Typedef', 'Keyword')
li('Special', 'PreProc')
li('SpecialChar', 'PreProc')
li('Tag', 'Keyword')
li('Delimiter', 'Keyword')
hi('SpecialComment', p.commentTag, nil, 'italic')
hi('Debug', p.debug, nil, 'italic')
-- Ignore
hi('Underlined', p.fg, nil, 'underline')
hi('Error', p.error, p.bg, 'underline')
hi('Todo', p.todo, nil, 'bold,italic')

-- some other groups
li('healthSuccess', 'IncSearh')
hi('NvimInternalError', p.error, p.error)
hi('RedrawDebugClear', p.fg, p.duplicateFromServer)
hi('RedrawDebugComposed', p.fg, p.search)
li('RedrawDebugRecompose', 'Error')

-- builtin terminal colors
g.terminal_color_0 = p.ANSIBlack
g.terminal_color_1 = p.ANSIRed
g.terminal_color_2 = p.ANSIGreen
g.terminal_color_3 = p.ANSIYellow
g.terminal_color_4 = p.ANSIBlue
g.terminal_color_5 = p.ANSIMagenta
g.terminal_color_6 = p.ANSICyan
g.terminal_color_7 = p.ANSIGray
g.terminal_color_8 = p.ANSIDarkGray
g.terminal_color_9 = p.ANSIBrightRed
g.terminal_color_10 = p.ANSIBrightGreen
g.terminal_color_11 = p.ANSIBrightYellow
g.terminal_color_12 = p.ANSIBrightBlue
g.terminal_color_13 = p.ANSIBrightMagenta
g.terminal_color_14 = p.ANSIBrightCyan
g.terminal_color_15 = p.ANSIWhite

-- the following code snippet fix an issue with CursorLine hi group
-- see https://github.com/neovim/neovim/issues/9019
cmd 'hi CursorLine ctermfg=white'

-- nvim-treesitter
li('TSAnnotation', 'PreProc')
li('TSAttribute', 'PreProc')
li('TSBoolean', 'Keyword')
li('TSCharacter', 'Character')
li('TSComment', 'Comment')
li('TSConstructor', 'Function')
li('TSConditional', 'Keyword')
li('TSConstant', 'Constant')
li('TSConstBuiltin', 'Keyword')
li('TSConstMacro', 'cMacroName')
li('TSError', 'Error')
li('TSException', 'Keyword')
li('TSField', 'InstanceField')
li('TSFloat', 'Number')
li('TSFunction', 'Function')
li('TSFuncBuiltin', 'Normal')
li('TSFuncMacro', 'cMacroName')
li('TSInclude', 'Keyword')
li('TSKeyword', 'Keyword')
li('TSKeywordFunction', 'Keyword')
li('TSLabel', 'Normal')
li('TSMethod', 'Function')
li('TSNamespace', 'Normal')
li('TSNone', 'Normal')
li('TSNumber', 'Number')
li('TSOperator', 'Normal')
li('TSParameter', 'Normal')
li('TSParameterReference', 'Normal')
li('TSProperty', 'TSField')
li('TSPunctDelimiter', 'Normal')
li('TSPunctBracket', 'Normal')
li('TSPunctSpecial', 'Keyword')
li('TSRepeat', 'Keyword')
li('TSString', 'String')
li('TSStringRegex', 'Number')
li('TSStringEscape', 'Keyword')
li('TSSymbol', 'Identifier')
li('TSTag', 'Keyword')
li('TSTagDelimiter', 'Normal')
li('TSText', 'Normal')
hi('TSStrong', p.fg, nil, 'bold')
hi('TSEmphasis', p.fg, nil, 'italic')
hi('TSUnderline', p.fg, nil, 'underline')
hi('TSStrike', p.fg, nil, 'strikethrough')
hi('TSTitle', p.fg, nil, 'bold,underline')
li('TSLiteral', 'Normal')
li('TSURI', 'markdownLinkText')
li('TSNote', 'CodeInfo')
li('TSWarning', 'Warning')
li('TSDanger', 'Error')
li('TSType', 'Normal')
li('TSTypeBuiltin', 'Keyword')
li('TSVariable', 'Normal')
li('TSVariableBuiltin', 'Keyword')

-- LSP
li('LspReferenceText', 'IdentifierUnderCaret')
li('LspReferenceRead', 'IdentifierUnderCaret')
li('LspReferenceWrite', 'IdentifierUnderCaretWrite')
li('LspDiagnosticsDefaultError', 'Error')
li('LspDiagnosticsDefaultWarning', 'TSWarning')
li('LspDiagnosticsDefaultInformation', 'CodeInfo')
li('LspDiagnosticsDefaultHint', 'CodeHint')
li('LspDiagnosticsSignError', 'ErrorSign')
li('LspDiagnosticsSignWarning', 'WarningSign')
li('LspDiagnosticsSignInformation', 'InfoSign')
li('LspDiagnosticsSignHint', 'HintSign')
li('LspDiagnosticsUnderlineError', 'Error')
li('LspDiagnosticsUnderlineWarning', 'Warning')
li('LspDiagnosticsUnderlineInformation', 'CodeInfo')
li('LspDiagnosticsUnderlineHint', 'CodeHint')
li('LspDiagnosticsFloatingError', 'NormalFloat')
li('LspDiagnosticsFloatingWarning', 'NormalFloat')
li('LspDiagnosticsFloatingInformation', 'NormalFloat')
li('LspDiagnosticsFloatingHint', 'NormalFloat')

