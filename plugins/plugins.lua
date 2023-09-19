vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use { "wbthomason/packer.nvim" } -- let packer manage itself

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use {
    'nvim-lua/plenary.nvim'
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'neovim/nvim-lspconfig'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    -- :TSUpdate[Sync] doesn't exist until plugin/nvim-treesitter is loaded (i.e. not after first install); call update() directly
    run = function() require("nvim-treesitter.install").update { with_sync = true } end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  use {
    'crusj/bookmarks.nvim',
    branch = 'main',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use "EdenEast/nightfox.nvim"

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use 'simrat39/rust-tools.nvim'
  use 'mfussenegger/nvim-dap'
--  use {
--    'nvim-orgmode/orgmode',
--    config = function() require('orgmode').setup{} end
--  }

  -- Completion framework:
  use 'hrsh7th/nvim-cmp'

  -- LSP completion source:
  use 'hrsh7th/cmp-nvim-lsp'

  -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'


  -- compiler output
  use {
    'folke/trouble.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

end)
