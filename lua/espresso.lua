--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local M = {}

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
  selection = '#7d5b54',
  cursorLine = '#3A312C',
  cursorLineNr = '#A4A3A3',
  errorMsg = '#CC666E',
  error = '#BC3F3C',
  warning = '#4A3F10',
  muted = '#734C36',
  stdOutput = '#E4E4FF',
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
  escapeSequence = '#2FE420',
  number = '#44AA43',
  commentTag = '#8A653B',
  ['function'] = '#FF9358',
  diffAdd = '#294436',
  diffText = '#385570',
  diffDelete = '#656E76',
  diffChange = '#374752',
  addStripe = '#384C38',
  whitespaceStripe = '#4C4638',
  changeStripe = '#374752',
  deleteStripe = '#656E76',
  typo = '#659C6B',
  macroName = '#908B25',
  namespace = '#B5B6E3',
  hint = '#9C8366',
  information = '#80807F',
  debug = '#666D75',
  errorStripe = '#FF0000',
  warningStripe = '#FFFF00',
  informationStripe = '#FFFFCC',
  hintStripe = '#F49810',
  menu = '#432717',
  menuSel = '#A65D33',
  menuSBar = '#7f4A2B',
  statusLine = '#432717',
  statusLineNC = '#2A190E',
  duplicateFromServer = '#30322B',
  wrapGuide = '#4D4D4D',
  variable = '#318495',
  ANSIBlack = '#000000',
  ANSIRed = '#FF6767',
  ANSIGreen = '#68E868',
  ANSIYellow = '#754200',
  ANSIBlue = '#C7C7FF',
  ANSIMagenta = '#FF2EFF',
  ANSICyan = '#06B8B8',
  ANSIGray = '#A7A7A7',
  ANSIDarkGray = '#595959',
  ANSIBrightRed = '#FF4050',
  ANSIBrightGreen = '#4FC414',
  ANSIBrightYellow = '#E5BF00',
  ANSIBrightBlue = '#1FB0FF',
  ANSIBrightMagenta = '#ED7EED',
  ANSIBrightCyan = '#00E5E5',
  ANSIWhite = '#FFFFFF',
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
hi('Error', p.error, p.bg, 'underline')
hi('Warning', nil, p.warning)
hi('Information', p.information)
hi('Hint', p.hint)
hi('ErrorSign', p.errorStripe)
hi('WarningSign', p.warningStripe)
hi('InformationSign', p.informationStripe)
hi('HintSign', p.hintStripe)
hi('IdentifierUnderCaret', nil, p.identifierUnderCaret)
hi('IdentifierUnderCaretWrite', nil, p.identifierUnderCaretWrite)
hi('GitAddSign', p.addStripe)
hi('GitChangeSign', p.changeStripe)
hi('GitDeleteSign', p.deleteStripe)
hi('GitChangeDeleteSign', p.whitespaceStripe)

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
hi('SignColumn', nil, p.bg)
hi('IncSearch', nil, p.incSearch)
li('Substitute', 'Search')
hi('LineNr', p.fg, p.bg)
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
hi('Pmenu', p.fg, p.menu)
hi('PmenuSel', p.fg, p.menuSel)
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
hi('StatusLine', p.fg, p.statusLine)
hi('StatusLineNC', p.fg, p.statusLineNC)
hi('TabLine', p.fg, p.statusLineNC)
hi('TabLineFill', p.statusLineNC, p.statusLineNC)
hi('TabLineSel', p.fg, p.statusLine)
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
li('PreProc', 'Keyword')
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
-- Error defined above
hi('Underlined', p.fg, nil, 'underline')
hi('Todo', p.todo, nil, 'bold,italic')

-- some other groups
li('healthSuccess', 'IncSearh')
hi('NvimInternalError', p.error, p.error)
hi('RedrawDebugClear', p.fg, p.duplicateFromServer)
hi('RedrawDebugComposed', p.fg, p.search)
li('RedrawDebugRecompose', 'Error')
hi('FloatBorder', p.fg, p.menu)

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
li('TSConstBuiltin', 'Constant')
hi('TSConstMacro', p.macroName)
li('TSError', 'Error')
li('TSException', 'Keyword')
hi('TSField', p.variable)
li('TSFloat', 'Number')
li('TSFunction', 'Function')
li('TSFuncBuiltin', 'Normal')
li('TSFuncMacro', 'TSConstMacro')
li('TSInclude', 'Keyword')
li('TSKeyword', 'Keyword')
li('TSKeywordFunction', 'Keyword')
li('TSKeywordOperator', 'Keyword')
li('TSLabel', 'Normal')
li('TSMethod', 'Function')
hi('TSNamespace', p.namespace)
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
hi('TSStringEscape', p.escapeSequence)
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
hi('TSURI', p.todo, nil, 'italic')
li('TSMath', 'Special')
li('TSTextReference', 'Comment')
li('TSEnviroment', 'Macro')
li('TSEnviromentName', 'Type')
li('TSNote', 'Information')
li('TSWarning', 'Warning')
li('TSDanger', 'Error')
li('TSType', 'Normal')
li('TSTypeBuiltin', 'Keyword')
li('TSVariable', 'Normal')
li('TSVariableBuiltin', 'Constant')

-- LSP
li('LspReferenceText', 'IdentifierUnderCaret')
li('LspReferenceRead', 'IdentifierUnderCaret')
li('LspReferenceWrite', 'IdentifierUnderCaretWrite')
li('LspDiagnosticsDefaultError', 'Error')
li('LspDiagnosticsDefaultWarning', 'Warning')
li('LspDiagnosticsDefaultInformation', 'Information')
li('LspDiagnosticsDefaultHint', 'Hint')
li('LspDiagnosticsSignError', 'ErrorSign')
li('LspDiagnosticsSignWarning', 'WarningSign')
li('LspDiagnosticsSignInformation', 'InformationSign')
li('LspDiagnosticsSignHint', 'HintSign')
li('LspDiagnosticsUnderlineError', 'Error')
li('LspDiagnosticsUnderlineWarning', 'Warning')
li('LspDiagnosticsUnderlineInformation', 'Information')
li('LspDiagnosticsUnderlineHint', 'Hint')
li('LspDiagnosticsFloatingError', 'NormalFloat')
li('LspDiagnosticsFloatingWarning', 'NormalFloat')
li('LspDiagnosticsFloatingInformation', 'NormalFloat')
li('LspDiagnosticsFloatingHint', 'NormalFloat')

M.p = p
return M
