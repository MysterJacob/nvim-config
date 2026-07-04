require "map"

-- markdown-preview
vim.g.mkdp_page_title = '「${name}」'
vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_theme = 'dark'

-- autocomment
vim.g.default_inline_comment = '#'
vim.g.inline_comment_dict = {
  ["//"] = { "js", "ts", "cpp", "c", "h", "hpp", "dart", "vect", "frag", "java" },
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

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
-- require('nvim-autopairs').setup()
-- git
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
-- scope lines
-- require("ibl").setup({
--   indent = {
--     char = "▏",
--   },
--   scope = {
--     enabled = false
--   }
-- })
require("todo-comments").setup()
