--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local M = {}

local api = vim.api
local cmd = vim.cmd
local g = vim.g

local p = require('espresso.palette')

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

function M.init()
  --[[ The CursorLine background will be overloaded by any group
  that defines a background value.
  Do not link to Normal group. Instead, link to this group.
  see https://github.com/neovim/neovim/issues/9019 ]]
  hl('Fg', p.fg)

  -- helper groups
  hl('Error', p.error, nil, 'underline')
  hl('Warning', nil, p.warning)
  hl('Information', p.information)
  hl('Hint', p.hint)
  hl('ErrorUnderline', nil, nil, 'undercurl', p.errorEffect)
  hl('WarnUnderline', nil, p.warning, 'underline', p.warnEffect)
  hl('InfoUnderline', nil, nil, 'underdashed', p.infoEffect)
  hl('HintUnderline', nil, nil, 'underdashed', p.hintEffect)
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
  li('WinBar', 'StatusLine')
  li('WinBarNC', 'StatusLineNC')

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
  -- TODO now deprecated, see `Treesitter` group below
  -- keep them for backward compatibility
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

  -- Treesitter
  li('@text.literal', 'Fg')
  li('@text.reference', 'Comment')
  hl('@text.title', p.fg, nil, { 'bold', 'underline' })
  hl('@text.uri', p.todo, nil, 'italic')
  hl('@text.underline', p.fg, nil, 'underline')
  li('@text.todo', 'Todo')
  li('@comment', 'Comment')
  li('@punctuation', 'Fg')
  li('@punctuation.bracket', 'Fg')
  li('@punctuation.brace', 'Fg')
  li('@punctuation.special', 'Keyword')
  li('@constant', 'Constant')
  li('@constant.builtin', 'Constant')
  hl('@constant.macro', p.macroName)
  li('@define', 'Keyword')
  li('@macro', '@constant.macro')
  li('@string', 'String')
  hl('@string.escape', p.escapeSequence)
  li('@string.special', '@string.escape')
  li('@string.regex', 'Number')
  li('@character', 'Character')
  li('@character.special', 'Character')
  li('@number', 'Number')
  li('@boolean', 'Keyword')
  li('@float', 'Number')
  li('@function', 'Function')
  li('@function.builtin', 'Fg')
  li('@function.macro', '@constant.macro')
  li('@parameter', 'Fg')
  li('@method', 'Function')
  hl('@field', p.variable)
  li('@property', '@field')
  li('@constructor', 'Function')
  li('@conditional', 'Keyword')
  li('@repeat', 'Keyword')
  li('@label', 'Fg')
  li('@operator', 'Fg')
  li('@keyword', 'Keyword')
  li('@exception', 'Keyword')
  li('@variable', 'Fg')
  li('@variable.builtin', 'Constant')
  li('@type', 'Fg')
  li('@type.definition', 'Keyword')
  li('@type.builtin', 'Keyword')
  li('@type.qualifier', 'Keyword')
  li('@storageclass', 'Keyword')
  hl('@structure', p.namespace) -- TODO need check
  hl('@namespace', p.namespace)
  li('@include', 'Keyword')
  li('@preproc', 'Keyword')
  li('@debug', 'Debug')
  li('@tag', 'Keyword')
  hl('@tag.attribute', p.fg, nil, 'italic')
  li('@tag.delimiter', 'Fg')
  hl('@strong', p.fg, nil, 'bold')
  hl('@emphasis', p.fg, nil, 'italic')
  hl('@strike', p.fg, nil, 'strikethrough')
  li('@text', 'Fg')
  li('@math', 'Special')
  li('@environment', 'Macro')
  li('@environment.name', 'Type')
  li('@note', 'Information')
  li('@warning', 'Warning')
  li('@danger', 'Error')

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
end

return M
