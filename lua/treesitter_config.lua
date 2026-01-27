require('nvim-treesitter').setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}
require("nvim-ts-autotag").setup();
