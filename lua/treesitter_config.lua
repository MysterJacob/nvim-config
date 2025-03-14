require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    --         disable = "python"
  },
  indent = {
    enable = true
  }
}
require("nvim-ts-autotag").setup();
