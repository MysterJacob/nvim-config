vim.g.mapleader = ","
vim.opt.mouse = nil
vim.opt.hls = true
vim.opt.ruler = true
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ic = false
vim.opt.expandtab = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.foldlevel = 5
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.wrap = false
vim.opt.swapfile = false
vim.o.background = "dark"

vim.o.termguicolors = false

vim.cmd([[
"Vim airline
let g:airline_section_error = ''
let g:airline_theme='dark'
set nofoldenable
vnoremap < <gv
vnoremap > >gv
colorscheme kanagawa
set signcolumn=auto
hi! link SignColumn Normal
]])
