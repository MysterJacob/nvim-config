require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "pyright",
    "rust_analyzer",
    "lua_ls",
    "biome",
    "html",
    "vuels",
    "cssls",
  }
})
