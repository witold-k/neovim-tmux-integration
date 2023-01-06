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

--  use {
--    'nvim-orgmode/orgmode',
--    config = function() require('orgmode').setup{} end
--  }

end)
