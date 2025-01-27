require "map"

-- markdown-preview
vim.g.mkdp_page_title = '「${name}」'
vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_theme = 'dark'
vim.g.default_inline_comment = '#'
vim.g.inline_comment_dict = {
  ["//"] = { "js", "ts", "cpp", "c", "h", "hpp", "dart" },
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
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
    virt_text_priority = 0,
    use_focus = true,
  },
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
