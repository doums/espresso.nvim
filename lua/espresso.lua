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
  null = 'NONE',
  bg = '#2B2B2B',
  fg = '#A9B7C6',
  cursor = '#BBBBBB',
  identifierUnderCaret = '#344134',
  identifierUnderCaretWrite = '#40332B',
  gutter = '#313335',
  selection = '#214283',
  cursorLine = '#323232',
  cursorLineNr = '#A4A3A3',
  errorMsg = '#CC666E',
  error = '#BC3F3C',
  warning = '#A9B7C6',
  muted = '#606060',
  link = '#287BDE',
  stdOutput = '#BBBBBB',
  lineNumber = '#606366',
  matchBraceFg = '#FFEF28',
  matchBraceBg = '#3B514D',
  todo = '#A8C023',
  search = '#32593D',
  incSearch = '#155221',
  foldedFg = '#8C8C8C',
  foldedBg = '#3A3A3A',
  constant = '#9876AA',
  keyword = '#CC7832',
  comment = '#808080',
  docComment = '#629755',
  string = '#6A8759',
  number = '#6897BB',
  delimiter = '#CC7832',
  specialComment = '#8A653B',
  ['function'] = '#FFC66D',
  diffAdd = '#294436',
  diffText = '#385570',
  diffDelete = '#484A4A',
  diffChange = '#303C47',
  addStripe = '#384C38',
  stripeWhiteSpace = '#4C4638',
  changeStripe = '#374752',
  deleteStripe = '#656E76',
  typo = '#659C6B',
  metaData = '#BBB529',
  macroName = '#908B25',
  cDataStructure = '#B5B6E3',
  cStructField = '#9373A5',
  debug = '#666D75',
  codeError = '#532B2E',
  codeWarning = '#52503A',
  errorStripe = '#9E2927',
  warnStripe = '#BE9117',
  infoStripe = '#756D56',
  hintStripe = '#6c7176',
  typeDef = '#B9BCD1',
  menu = '#46484A',
  menuFg = '#BBBBBB',
  menuSel = '#113A5C',
  menuSBar = '#616263',
  tag = '#E8BF6A',
  entity = '#6D9CBE',
  htmlAttribute = '#BABABA',
  htmlString = '#A5C261',
  tsObject = '#507874',
  statusLine = '#3C3F41',
  statusLineFg = '#BBBBBB',
  statusLineNC = '#787878',
  tabLineSel = '#4E5254',
  shCommand = '#C57633',
  templateLanguage = '#232525',
  rustMacro = '#4EADE5',
  rustLifetime = '#20999D',
  duplicateFromServer = '#5E5339',
  hintBg = '#3B3B3B',
  hintFg = '#787878',
  wrapGuide = '#2F2F2F',
  UIBorder = '#616161',
  UISelection = '#0D293E',
  ANSIBlack = '#FFFFFF',
  ANSIRed = '#FF6B68',
  ANSIGreen = '#A8C023',
  ANSIYellow = '#D6BF55',
  ANSIBlue = '#5394EC',
  ANSIMagenta = '#AE8ABE',
  ANSICyan = '#299999',
  ANSIGray = '#999999',
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
  local decoration = style or 'NONE'
  local hi_command = string.format('hi %s %s %s %s', name, fg, bg, decoration)
  cmd(hi_command)
end

local function li(target, source)
  cmd(string.format('hi! link %s %s', target, source))
end

-- builtin groups `:h highlight-groups`
hi('ColorColumn', p.null, p.wrapGuide)
hi('Conceal', p.muted, p.bg)
hi('Cursor', p.cursor)
li('lCursor', 'Cursor')
li('CursorIM', 'Cursor')
li('CursorColumn', 'CursorLine')
hi('CursorLine', p.null, p.cursorLine, 'NONE')
li('Directory', 'NormalFg')
hi('DiffAdd', p.null, p.diffAdd)
hi('DiffChange', p.null, p.diffChange)
hi('DiffDelete', p.null, p.diffDelete)
hi('DiffText', p.null, p.diffText)
li('EndOfBuffer', 'NonText')
-- TermCursor
-- TermCursorNC
hi('ErrorMsg', p.errorMsg)
hi('VertSplit', p.muted)
hi('Folded', p.foldedFg, p.foldedBg)
li('FoldColumn', 'Folded')
hi('SignColumn', p.null, p.gutter)
hi('IncSearch', p.null, p.incSearch)
li('Substitute', 'Search')
hi('LineNr', p.lineNumber, p.gutter)
hi('CursorLineNr', p.cursorLineNr, p.cursorLine)
hi('MatchParen', p.matchBraceFg, p.matchBraceBg, 'bold')
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
hi('Search', p.null, p.search)
li('SpecialKey', 'NonText')
hi('SpellBad', p.typo, p.null, 'underline')
li('SpellCap', 'SpellBad')
li('SpellLocal', 'SpellBad')
li('SpellRare', 'SpellBad')
hi('StatusLine', p.statusLineFg, p.statusLine)
hi('StatusLineNC', p.statusLineNC, p.statusLine)
hi('TabLine', p.statusLineFg, p.statusLine)
hi('TabLineFill', p.statusLine, p.statusLine)
hi('TabLineSel', p.fg, p.tabLineSel)
li('Title', 'Special')
hi('Visual', p.null, p.selection)
li('VisualNOS', 'Visual')
hi('WarningMsg', p.warning)
li('Whitespace', 'NonText')
li('WildMenu', 'PmenuSel')

-- common groups `:h group-name`
hi('Comment', p.comment)
hi('Constant', p.constant, p.null, 'italic')
hi('String', p.string)
li('Character', 'String')
hi('Number', p.number)
li('Boolean', 'Keyword')
li('Float', 'Number')
li('Identifier', 'NormalFg')
hi('Function', p['function'])
li('Statement', 'Keyword')
li('Conditional', 'Keyword')
li('Repeat', 'Keyword')
li('Label', 'Keyword')
li('Operator', 'Keyword')
hi('Keyword', p.keyword)
li('Exception', 'Keyword')
hi('PreProc', p.metaData)
li('Include', 'PreProc')
li('Define', 'PreProc')
li('Macro', 'PreProc')
li('PreCondit', 'PreProc')
li('Type', 'Keyword')
li('StorageClass', 'Keyword')
li('Structure', 'Keyword')
hi('Typedef', p.typeDef)
li('Special', 'PreProc')
li('SpecialChar', 'PreProc')
li('Tag', 'Keyword')
hi('Delimiter', p.delimiter)
hi('SpecialComment', p.specialComment, p.null, 'italic')
hi('Debug', p.debug, p.null, 'italic')
-- Ignore
hi('Underlined', p.fg, p.null, 'underline')
hi('Error', p.fg, p.codeError)
hi('Todo', p.todo, p.null, 'italic')

-- some other groups
li('healthSuccess', 'IncSearh')
hi('NvimInternalError', p.error, p.error)
hi('RedrawDebugClear', p.fg, p.duplicateFromServer)
hi('RedrawDebugComposed', p.fg, p.search)
hi('RedrawDebugRecompose', p.fg, p.codeError)

-- builtin terminal colors
g.terminal_color_0 = p.ANSIBlack[0]
g.terminal_color_1 = p.ANSIRed[0]
g.terminal_color_2 = p.ANSIGreen[0]
g.terminal_color_3 = p.ANSIYellow[0]
g.terminal_color_4 = p.ANSIBlue[0]
g.terminal_color_5 = p.ANSIMagenta[0]
g.terminal_color_6 = p.ANSICyan[0]
g.terminal_color_7 = p.ANSIGray[0]
g.terminal_color_8 = p.ANSIDarkGray[0]
g.terminal_color_9 = p.ANSIBrightRed[0]
g.terminal_color_10 = p.ANSIBrightGreen[0]
g.terminal_color_11 = p.ANSIBrightYellow[0]
g.terminal_color_12 = p.ANSIBrightBlue[0]
g.terminal_color_13 = p.ANSIBrightMagenta[0]
g.terminal_color_14 = p.ANSIBrightCyan[0]
g.terminal_color_15 = p.ANSIWhite[0]

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
li('TSError', 'codeError')
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
li('TSNamespace', 'cDataStructure')
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
li('TSTag', 'htmlTag')
li('TSTagDelimiter', 'htmlTag')
li('TSText', 'Normal')
hi('TSStrong', p.fg, p.null, 'bold')
hi('TSEmphasis', p.fg, p.null, 'italic')
hi('TSUnderline', p.fg, p.null, 'underline')
hi('TSStrike', p.fg, p.null, 'strikethrough')
hi('TSTitle', p.fg, p.null, 'bold,underline')
li('TSLiteral', 'Normal')
li('TSURI', 'markdownLinkText')
li('TSNote', 'CodeInfo')
li('TSWarning', 'CodeWarning')
li('TSDanger', 'CodeError')
li('TSType', 'Normal')
li('TSTypeBuiltin', 'Keyword')
li('TSVariable', 'Normal')
li('TSVariableBuiltin', 'Keyword')

-- LSP
li('LspReferenceText', 'IdentifierUnderCaret')
li('LspReferenceRead', 'IdentifierUnderCaret')
li('LspReferenceWrite', 'IdentifierUnderCaretWrite')
li('LspDiagnosticsDefaultError', 'CodeError')
li('LspDiagnosticsDefaultWarning', 'CodeWarning')
li('LspDiagnosticsDefaultInformation', 'CodeInfo')
li('LspDiagnosticsDefaultHint', 'CodeHint')
li('LspDiagnosticsSignError', 'ErrorSign')
li('LspDiagnosticsSignWarning', 'WarningSign')
li('LspDiagnosticsSignInformation', 'InfoSign')
li('LspDiagnosticsSignHint', 'HintSign')
li('LspDiagnosticsUnderlineError', 'CodeError')
li('LspDiagnosticsUnderlineWarning', 'CodeWarning')
li('LspDiagnosticsUnderlineInformation', 'CodeInfo')
li('LspDiagnosticsUnderlineHint', 'CodeHint')
li('LspDiagnosticsFloatingError', 'NormalFloat')
li('LspDiagnosticsFloatingWarning', 'NormalFloat')
li('LspDiagnosticsFloatingInformation', 'NormalFloat')
li('LspDiagnosticsFloatingHint', 'NormalFloat')

