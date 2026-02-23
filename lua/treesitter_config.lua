require('nvim-treesitter.configs').setup {
  sync_install = true,
  ignore_install = { "ipkg" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
--   ensure_installed = 'all'
}
require("nvim-ts-autotag").setup();
