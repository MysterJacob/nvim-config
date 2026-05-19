vim.g.transparent_enabled = true
require("transparent").setup({ -- Optional, you don't have to run setup.
  groups = {                   -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer', 'FoldColumn'
  },
  extra_groups = {
    "NormalFloat",    -- plugins which have float panel such as Lazy, Mason, LspInfo
    "FloatBorder",
    "NvimTreeNormal", -- NvimTree
    "TelescopeNormal",
    "TelescopeBorder",
    "TelescopeSelectionCaret",
    "TelescopeMatching",
    "TelescopePromptNormal",
    "TelescopePromptTitle",
    "TelescopePromptPrefix",
    "TelescopePromptBorder",
    "TelescopePreviewTitle",
    "TelescopePreviewBorder",
    "TelescopeResultsTitle",
    "TelescopeResultsBorder",
    "UfoPreviewSbar",
    "UfoPreviewThumb",
    "UfoPreviewWinBar",
    "UfoPreviewCursorLine",
    "UfoFoldedEllipsis",
    "UfoCursorFoldedLine",
  }, -- table: additional groups that should be cleared
  exclude_groups = {
    "CursorLine"
  }, -- table: groups you don't want to clear
})

vim.cmd([[
  function! PatchHighlights() abort
     hi WinSeparator guifg=#54546f guibg=None
     hi NvimTreeCursorLine guibg=#463636
  endfunction

  autocmd ColorScheme * call PatchHighlights()

  colorscheme yorumi
]])

