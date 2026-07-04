vim.g.transparent_enabled = true

require("transparent").setup({
  groups = {
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer', 'FoldColumn'
  },
  extra_groups = {
    "NormalFloat", "FloatBorder",
    "TelescopeNormal", "TelescopeBorder",
    "TelescopeSelectionCaret", "TelescopeMatching",
    "TelescopePromptNormal", "TelescopePromptTitle",
    "TelescopePromptPrefix", "TelescopePromptBorder",
    "TelescopePreviewTitle", "TelescopePreviewBorder",
    "TelescopeResultsTitle", "TelescopeResultsBorder",
    "UfoPreviewSbar", "UfoPreviewThumb", "UfoPreviewWinBar",
    "UfoPreviewCursorLine", "UfoFoldedEllipsis", "UfoCursorFoldedLine", "NvimTreeNormal", "NvimTreeNormalNC",
    "NvimTreeRootFolder"
  },
  exclude_groups = { "CursorLine" },
})

-- This autocmd always fires LAST, overriding whatever any colorscheme set
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  pattern = "*",
  callback = function()
    local transparent = { bg = "NONE", ctermbg = "NONE" }

    -- Core editor
    for _, grp in ipairs({
      "Normal", "NormalNC", "NormalFloat",
      "SignColumn", "LineNr", "CursorLineNr",
      "StatusLine", "StatusLineNC",
      "EndOfBuffer", "FoldColumn",
      "Whitespace", "NonText",
    }) do
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = grp, link = false })
      if ok then
        hl.bg = nil
        hl.ctermbg = nil
        vim.api.nvim_set_hl(0, grp, hl) -- keeps fg/gui, nukes bg only
      end
    end

    -- Indent guides (works for ibl, indent-blankline v2, listchars)
    for _, grp in ipairs({
      "IblIndent", "IblScope",
      "IndentBlanklineChar", "IndentBlanklineSpaceChar",
      "IndentBlanklineContextChar",
    }) do
      pcall(vim.api.nvim_set_hl, 0, grp, { bg = "NONE", ctermbg = "NONE" })
    end

    -- NvimTree: keep visible with a subtle bg
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#14141f" })
    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "#14141f" })
    vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#463636" })

    -- Borders / separators
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#54546f", bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatBorder", transparent)
  end,
})

vim.cmd("colorscheme yorumi")
