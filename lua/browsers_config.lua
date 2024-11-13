require "map"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 28,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require('telescope').setup()
Map("n", "<leader>tf", ":Telescope find_files<CR>", { silent = true })
Map("n", "<leader>tg", ":Telescope live_grep<CR>", { silent = true })
Map("n", "<leader>tb", ":Telescope buffers<CR>", { silent = true })
Map("n", "<leader>tt", ":Telescope help_tags<CR>", { silent = true })
