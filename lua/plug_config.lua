local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')

Plug('tpope/vim-fugitive')

Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
Plug('nvim-telescope/telescope-dap.nvim')

Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('pangloss/vim-javascript')
Plug('Civitasv/cmake-tools.nvim')

Plug('mfussenegger/nvim-dap')
Plug('theHamsta/nvim-dap-virtual-text')
Plug('rcarriga/nvim-dap-ui')
Plug('nvim-neotest/nvim-nio')
Plug('mfussenegger/nvim-dap-python')

Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/vim-vsnip')

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('ray-x/lsp_signature.nvim')
Plug('L3MON4D3/LuaSnip', { tag = 'v2.*', ['do'] = 'make install_jsregexp' })
Plug("lukas-reineke/indent-blankline.nvim")

Plug("lewis6991/gitsigns.nvim")
Plug('windwp/nvim-autopairs')
Plug('windwp/nvim-ts-autotag')
Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install' })
Plug('KarimElghamry/vim-auto-comment')
-- themes
Plug('chriskempson/base16-vim')
Plug("ellisonleao/gruvbox.nvim")
Plug("folke/tokyonight.nvim")
Plug("rebelot/kanagawa.nvim")
Plug("NLKNguyen/papercolor-theme")
Plug('catppuccin/nvim', { as = 'catppuccin' })
Plug('xiyaowong/transparent.nvim')

vim.call('plug#end')
