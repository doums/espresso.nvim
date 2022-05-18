--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local M = {}

local api = vim.api
local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local o = vim.o

if fn.has('termguicolors') ~= 1 or not o.termguicolors then
  api.nvim_echo({
    { '[espresso] truecolor must be enabled (see :h termguicolors).' },
  }, true, {})
  return
end

-- stuff for the legacy regex engine
cmd('highlight clear')
if fn.exists('syntax_on') == 1 then
  cmd('syntax reset')
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
  errorEffect = '#FF6767',
  warnEffect = '#BDAE9D',
  infoEffect = '#3592C4',
  hintEffect = '#713D40',
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
  diffDelete = '#484A4A',
  diffChange = '#30363E',
  addStripe = '#447152',
  whitespaceStripe = '#8F5247',
  changeStripe = '#43698D',
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
  codeLens = '#CA7E03',
  wrapGuide = '#312722',
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

local function hl(name, fg, bg, style, sp)
  local hl_map = { fg = fg, bg = bg, sp = sp }
  if type(style) == 'string' then
    hl_map[style] = 1
  elseif type(style) == 'table' then
    for _, v in ipairs(style) do
      hl_map[v] = 1
    end
  end
  api.nvim_set_hl(0, name, hl_map)
end

local function li(target, source)
  cmd(string.format('hi! link %s %s', target, source))
end

--[[ The CursorLine background will be overloaded by any group
--   that defines a background value.
--   Do not link to Normal group. Instead, link to this group.
--   see https://github.com/neovim/neovim/issues/9019 ]]
hl('Fg', p.fg)

-- helper groups
hl('Error', p.error, nil, 'underline')
hl('Warning', nil, p.warning)
hl('Information', p.information)
hl('Hint', p.hint)
hl('ErrorUnderline', nil, nil, 'undercurl', p.errorEffect)
hl('WarnUnderline', nil, p.warning, 'underline', p.warnEffect)
hl('InfoUnderline', nil, nil, 'underdash', p.infoEffect)
hl('HintUnderline', nil, nil, 'underdash', p.hintEffect)
hl('ErrorSign', p.errorStripe)
hl('WarningSign', p.warningStripe)
hl('InformationSign', p.informationStripe)
hl('HintSign', p.hintStripe)
hl('IdentifierUnderCaret', nil, p.identifierUnderCaret)
hl('IdentifierUnderCaretWrite', nil, p.identifierUnderCaretWrite)
hl('GitAddSign', p.addStripe)
hl('GitChangeSign', p.changeStripe)
hl('GitDeleteSign', p.deleteStripe)
hl('GitChangeDeleteSign', p.whitespaceStripe)

-- builtin groups `:h highlight-groups`
hl('ColorColumn', nil, p.wrapGuide)
hl('Conceal', p.muted, p.bg)
hl('Cursor', p.cursor)
li('lCursor', 'Cursor')
li('CursorIM', 'Cursor')
li('CursorColumn', 'CursorLine')
hl('CursorLine', nil, p.cursorLine)
li('Directory', 'Fg')
hl('DiffAdd', nil, p.diffAdd)
hl('DiffChange', nil, p.diffChange)
hl('DiffDelete', nil, p.diffDelete)
hl('DiffText', nil, p.diffText)
li('EndOfBuffer', 'NonText')
-- TermCursor
-- TermCursorNC
hl('ErrorMsg', p.errorMsg)
hl('VertSplit', p.muted)
hl('Folded', p.foldedFg, p.foldedBg)
li('FoldColumn', 'Folded')
hl('SignColumn', nil, p.bg)
hl('IncSearch', nil, p.incSearch)
li('CurSearch', 'IncSearch')
li('Substitute', 'Search')
hl('LineNr', p.fg, p.bg)
hl('CursorLineNr', p.constant, p.bg, 'bold')
hl('MatchParen', nil, p.matchBrace)
hl('ModeMsg', p.stdOutput)
li('MsgArea', 'Fg')
li('MsgSeparator', 'StatusLine')
li('MoreMsg', 'Fg')
hl('NonText', p.muted)
hl('Normal', p.fg, p.bg)
li('NormalFloat', 'Pmenu')
li('NormalNC', 'Fg')
hl('Pmenu', p.fg, p.menu)
hl('PmenuSel', p.fg, p.menuSel)
hl('PmenuSbar', p.menu, p.menu)
hl('PmenuThumb', p.menuSBar, p.menuSBar)
li('Question', 'Fg')
li('QuickFixLine', 'Fg')
hl('Search', nil, p.search)
li('SpecialKey', 'NonText')
hl('SpellBad', p.typo, nil, 'underline')
li('SpellCap', 'SpellBad')
li('SpellLocal', 'SpellBad')
li('SpellRare', 'SpellBad')
hl('StatusLine', p.fg, p.statusLine)
hl('StatusLineNC', p.fg, p.statusLineNC)
hl('TabLine', p.fg, p.statusLineNC)
hl('TabLineFill', p.statusLineNC, p.statusLineNC)
hl('TabLineSel', p.fg, p.statusLine)
li('Title', 'Special')
hl('Visual', nil, p.selection)
li('VisualNOS', 'Visual')
li('WarningMsg', 'Warning')
li('Whitespace', 'NonText')
li('WildMenu', 'PmenuSel')

-- common groups `:h group-name`
hl('Comment', p.comment, nil, 'italic')
hl('Constant', p.constant, nil, 'bold')
hl('String', p.string)
li('Character', 'String')
hl('Number', p.number)
li('Boolean', 'Keyword')
li('Float', 'Number')
li('Identifier', 'Fg')
hl('Function', p['function'], nil, 'bold')
li('Statement', 'Keyword')
li('Conditional', 'Keyword')
li('Repeat', 'Keyword')
li('Label', 'Keyword')
li('Operator', 'Keyword')
hl('Keyword', p.keyword, nil, 'bold')
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
hl('SpecialComment', p.commentTag, nil, 'italic')
hl('Debug', p.debug, nil, 'italic')
-- Ignore
-- Error defined above
hl('Underlined', p.fg, nil, 'underline')
hl('Todo', p.todo, nil, { 'bold', 'italic' })

-- some other groups
li('healthSuccess', 'IncSearh')
hl('NvimInternalError', p.error, p.error)
hl('RedrawDebugClear', p.fg, p.duplicateFromServer)
hl('RedrawDebugComposed', p.fg, p.search)
li('RedrawDebugRecompose', 'Error')
hl('FloatBorder', p.fg, p.menu)

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

-- nvim-treesitter
li('TSAttribute', 'PreProc')
li('TSBoolean', 'Keyword')
li('TSCharacter', 'Character')
li('TSCharacterSpecial', 'Character')
li('TSComment', 'Comment')
li('TSConditional', 'Keyword')
li('TSConstant', 'Constant')
li('TSConstBuiltin', 'Constant')
hl('TSConstMacro', p.macroName)
li('TSConstructor', 'Function')
li('TSDebug', 'Debug')
li('TSDefine', 'Keyword')
li('TSError', 'ErrorUnderline')
li('TSException', 'Keyword')
hl('TSField', p.variable)
li('TSFloat', 'Number')
li('TSFunction', 'Function')
li('TSFuncBuiltin', 'Fg')
li('TSFuncMacro', 'TSConstMacro')
li('TSInclude', 'Keyword')
li('TSKeyword', 'Keyword')
li('TSKeywordFunction', 'Keyword')
li('TSKeywordOperator', 'Keyword')
li('TSKeywordReturn', 'Keyword')
li('TSLabel', 'Fg')
li('TSMethod', 'Function')
hl('TSNamespace', p.namespace)
li('TSNone', 'Fg')
li('TSNumber', 'Number')
li('TSOperator', 'Fg')
li('TSParameter', 'Fg')
li('TSParameterReference', 'Fg')
li('TSPreProc', 'Keyword')
li('TSProperty', 'TSField')
li('TSPunctDelimiter', 'Fg')
li('TSPunctBracket', 'Fg')
li('TSPunctSpecial', 'Keyword')
li('TSRepeat', 'Keyword')
li('TSStorageClass', 'Keyword')
li('TSString', 'String')
li('TSStringRegex', 'Number')
hl('TSStringEscape', p.escapeSequence)
li('TSStringSpecial', 'TSStringEscape')
li('TSSymbol', 'Identifier')
li('TSTag', 'Keyword')
hl('TSTagAttribute', p.fg, nil, 'italic')
li('TSTagDelimiter', 'Fg')
li('TSText', 'Fg')
hl('TSStrong', p.fg, nil, 'bold')
hl('TSEmphasis', p.fg, nil, 'italic')
hl('TSUnderline', p.fg, nil, 'underline')
hl('TSStrike', p.fg, nil, 'strikethrough')
hl('TSTitle', p.fg, nil, { 'bold', 'underline' })
li('TSLiteral', 'Fg')
hl('TSURI', p.todo, nil, 'italic')
li('TSMath', 'Special')
li('TSTextReference', 'Comment')
li('TSEnviroment', 'Macro')
li('TSEnviromentName', 'Type')
li('TSNote', 'Information')
li('TSWarning', 'Warning')
li('TSDanger', 'Error')
li('TSTodo', 'Todo')
li('TSType', 'Fg')
li('TSTypeBuiltin', 'Keyword')
li('TSTypeQualifier', 'Keyword')
li('TSTypeDefinition', 'Keyword')
li('TSVariable', 'Fg')
li('TSVariableBuiltin', 'Constant')

-- LSP
li('LspReferenceText', 'IdentifierUnderCaret')
li('LspReferenceRead', 'IdentifierUnderCaret')
li('LspReferenceWrite', 'IdentifierUnderCaretWrite')
hl('LspCodeLens', p.codeLens, nil, 'italic')
li('LspCodeLensSeparator', 'LspCodeLens')
li('LspSignatureActiveParameter', 'Search')
li('DiagnosticError', 'Error')
li('DiagnosticWarn', 'Warning')
li('DiagnosticInfo', 'Information')
li('DiagnosticHint', 'Hint')
hl('DiagnosticSignError', p.errorStripe, nil, 'bold')
li('DiagnosticSignWarn', 'WarningSign')
li('DiagnosticSignInfo', 'InformationSign')
li('DiagnosticSignHint', 'HintSign')
li('DiagnosticUnderlineError', 'ErrorUnderline')
li('DiagnosticUnderlineWarn', 'WarnUnderline')
li('DiagnosticUnderlineInfo', 'InfoUnderline')
li('DiagnosticUnderlineHint', 'HintUnderline')
li('DiagnosticFloatingError', 'NormalFloat')
li('DiagnosticFloatingWarn', 'NormalFloat')
li('DiagnosticFloatingInfo', 'NormalFloat')
li('DiagnosticFloatingHint', 'NormalFloat')

M.p = p
return M
