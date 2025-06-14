return require('lazy').setup({
  {
   'vhyrro/luarocks.nvim',
   -- 'camspiers/luarocks.nvim',
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  },
  'pteroctopus/faster.nvim',

  {
    'saecki/crates.nvim',
    tag = 'stable',
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  },

  'nvim-lua/plenary.nvim',

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  'neovim/nvim-lspconfig',

  {
    'nvim-treesitter/nvim-treesitter',
    -- :TSUpdate[Sync] doesn't exist until plugin/nvim-treesitter is loaded (i.e. not after first install); call update() directly
    build = function() require("nvim-treesitter.install").update { with_sync = true } end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
  },

  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim'
  },

  -- navigation

  'smoka7/hop.nvim',
  'ggandor/leap.nvim',

  {
    'crusj/bookmarks.nvim',
    branch = 'main',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },

  "EdenEast/nightfox.nvim",

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "jdtls" },
    },
  },

  'williamboman/mason-lspconfig.nvim',

  'simrat39/rust-tools.nvim',

  -- debugger
  'mfussenegger/nvim-dap',

  {
    "eatgrass/maven.nvim",
    cmd = { "Maven", "MavenExec" },
    dependencies = "nvim-lua/plenary.nvim"
  },

  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' }
  },

  -- Completion framework:
  -- 'Saghen/blink.cmp',
  'hrsh7th/nvim-cmp',

  -- LSP completion source:
  'hrsh7th/cmp-nvim-lsp',

  -- Useful completion sources:
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',

  -- compiler output
  {
    'folke/trouble.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },

})
