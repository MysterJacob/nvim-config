local theme = require("kanagawa")
theme.setup({
  compile = false,    -- enable compiling the colorscheme
  undercurl = true,   -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = vim.g.transparent_enabled,   -- do not set background color
  dimInactive = false,                       -- dim inactive window `:h hl-NormalNC`
  terminalColors = true,                     -- define vim.g.terminal_color_{0,17}
  colors = {                                 -- add/modify theme and palette colors
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors)   -- add/modify highlights
    return {
      -- LineNr = { bg = colors.palette.sumiInk3 }
    }
  end,
  theme = "wave",      -- Load "wave" theme when 'background' option is not set
  background = {       -- map the value of 'background' option to a theme
    dark = "wave",     -- try "dragon" !
    light = "lotus"
  },
})
require("transparent").setup({ -- Optional, you don't have to run setup.
  groups = {                   -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  extra_groups = {
    "NormalFloat",        -- plugins which have float panel such as Lazy, Mason, LspInfo
    "FloatBorder",
    "NvimTreeNormal",     -- NvimTree
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
    "TelescopeResultsBorder"
  },                     -- table: additional groups that should be cleared
  exclude_groups = {},   -- table: groups you don't want to clear
})
vim.g.transparent_enabled = true
