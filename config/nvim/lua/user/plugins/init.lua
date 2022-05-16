local buf_keymap = vim.api.nvim_buf_set_keymap

vim.cmd [[packadd packer.nvim]]

-- Auto reloads neovim whenever you save the plugins.lua file.
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost init.lua source <afile> | PackerSync
    augroup end
]]

local ok, packer = pcall(require, 'packer')
if not ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = "rounded" }
        end,
    },
}

packer.startup(function()
    use 'wbthomason/packer.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    -- Cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lua'

    -- jdtls
    use 'mfussenegger/nvim-jdtls'

    -- Vsnip
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- friendly-snippets
    use 'rafamadriz/friendly-snippets'

    -- Treesittre
    use {
         'nvim-treesitter/nvim-treesitter',
         run = ':TSUpdate'
    }

    -- Themes
    use 'tiagovla/tokyodark.nvim'
    use 'rakr/vim-one'
    use 'sjl/badwolf'
    use 'jacoborus/tender.vim'
    use 'morhetz/gruvbox'
    use 'marko-cerovac/material.nvim'
    use { "Everblush/everblush.vim" }
    use 'rebelot/kanagawa.nvim'

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'ahmedkhalf/project.nvim'
    use 'nvim-telescope/telescope-project.nvim'

    -- Dashboard
    use 'glepnir/dashboard-nvim'

    -- Status Line Customization
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    -- Nvim Tree
    use {
         'kyazdani42/nvim-tree.lua',
         requires = {
             'kyazdani42/nvim-web-devicons'
         }
    }

    -- Toggle Term
    use 'akinsho/toggleterm.nvim'

    -- Which Key
    use 'folke/which-key.nvim'

    use 'baskerville/vim-sxhkdrc'

    -- use 'mhartington/formatter.nvim'

    use "lukas-reineke/lsp-format.nvim"
end)

require 'user.plugins.nvim-tree'
require 'user.plugins.telescope'
require 'user.plugins.lsp'
require 'user.plugins.cmp'
require 'user.plugins.toggleterm'
require 'user.plugins.dashboard'
require 'user.plugins.airline'
require 'user.plugins.project_nvim'
require 'user.plugins.format-config'
