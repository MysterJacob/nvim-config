local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/vim-snippets/snippets/", "~/.config/nvim/snippets/" } })
