require('luarocks-nvim').setup {
  priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  rocks = { 'luasystem', 'luafilesystem' }
}

