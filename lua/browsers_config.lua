require "map"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = 'right'
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set("n", "<leader>b", function()
  require("nvim-tree.api").tree.toggle();
  require('lualine').refresh();
end)

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
  pattern = 'NvimTree*',
  callback = function()
    local hl = vim.api.nvim_get_hl(0, { name = 'Cursor' })
    vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', hl, { blend = 100 }))
    vim.opt.guicursor:append('a:Cursor/lCursor')
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'WinClosed' }, {
  pattern = 'NvimTree*',
  callback = function()
    local hl = vim.api.nvim_get_hl(0, { name = 'Cursor' })
    vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', hl, { blend = 0 }))
    vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
  end,
})

local telescope = require('telescope')
telescope.setup({
  defaults = {
    file_ignore_patterns = { "*.git/*", "node_modules/*" },
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        width = { padding = 0 },
        height = { padding = 0 },
        preview_width = 0.45,
        preview_cutoff = 100,
      },
    },
    sorting_strategy = "ascending",
  },
  pickers = {
    diagnostics = {
      preview = false
    }
  }
})
telescope.load_extension("dap")

local opts = { silent = true }
Map("n", "<leader>tf", ":Telescope find_files<CR>", opts)
Map("n", "<leader>tg", ":Telescope live_grep<CR>", opts)
Map("n", "<leader>tt", ":Telescope help_tags<CR>", opts)
Map("n", "<leader>v", ":Telescope buffers initial_mode=normal<CR>", opts)
Map('n', '<leader>tD', ":Telescope lsp_declarations initial_mode=normal<CR>", opts)
Map('n', '<leader>td', ":Telescope lsp_definitions initial_mode=normal<CR>", opts)
Map('n', '<leader>ti', ":Telescope lsp_implementations initial_mode=normal<CR>", opts)
Map('n', '<leader>tr', ":Telescope lsp_references initial_mode=normal<CR>", opts)
Map('n', '<leader>t[', ":Telescope diagnostics initial_mode=normal<CR>", opts)
Map('n', '<leader>ts', ":Telescope lsp_document_symbols<CR>", opts)
