local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "../snips" } })
require("luasnip.loaders.from_snipmate").lazy_load()

