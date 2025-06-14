require("mason").setup()
require("mason-lspconfig").setup({
  automatic_enable = false,
  ensure_installed = {
    "clangd",
    "pyright",
    "rust_analyzer",
    "lua_ls",
    "biome",
    "html",
    "vuels",
    "cssls",
    "ruff"
  }
})
