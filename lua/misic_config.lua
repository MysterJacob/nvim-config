require "map"

Map("n", "<leader>b", ":NvimTreeToggle<CR>", { silent = true })
-- markdown-preview
vim.g.mkdp_page_title = '「${name}」'
vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_theme = 'dark'
vim.g.default_inline_comment = '#'
vim.g.inline_comment_dict = {
  ["//"] = { "js", "ts", "cpp", "c", "dart" },
  ["#"] = { 'py', 'sh' },
  ["--"] = { 'lua', 'sql' },
  ["\""] = { 'vim' },
  ["<!--"] = { 'html' },
  [";"] = { 'ini' },
}
Map("n", "<leader>/", ":AutoInlineComment<CR>", { silent = true })
Map("i", "<C-/>", ":AutoInlineComment<CR>", { silent = true })

-- Auto pairs
require('nvim-ts-autotag').setup()
require("nvim-autopairs").setup()
-- Github
require('gitsigns').setup({
  current_line_blame = true,
  signcolumn = false,
})
-- Scope
require("ibl").setup({
  indent = {
    char = "▏",
  },
  scope = {
    enabled = false
  }
})
