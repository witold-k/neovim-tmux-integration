_G.vim = vim -- make lsp checker happy

local home = os.getenv("HOME")
local path = require('pl.path')

local nvim_path = vim.loop.exepath()
local nvim_lua  = path.normpath(nvim_path .. '/../../../share/nvim/runtime/lua') .. '/?.lua'
-- print('nvim main   lua path: ' .. nvim_lua)

local config = home .. '/.config/nvim'
local config_lua = config .. '/?.lua'
-- print('nvim config lua path: ' .. config_lua)

package.path = package.path .. ';' .. config_lua .. ';' .. nvim_lua

require('lazy-config')

-- line numbers
vim.opt.number = true
-- vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 4       -- number of visual spaces per TAB
vim.opt.softtabstop = 4   -- number of spaces in tab when editing
vim.opt.shiftwidth = 4    -- number of spaces to use for autoindent
vim.opt.expandtab = true  -- tabs are space
vim.opt.autoindent = true
vim.opt.copyindent = true -- copy indent from the previous line

-- line wrapping
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.h", "*.c", "*.hh", "*.cc", "*.hpp", "*.cpp", "*.rs", "*.in",
              "CMake*.txt", "*.cmake", "*meson",
              "*.java", "*.lua", "*.py", "*.sh", "*.el", "*.json",
              "*.xml", "*.html",
              "*.bb", "*.bbclass",
              "*.dts", "*.dtsi",
              "**.md", "*.inc",
              "Dockerfile", "Justfile", "Makefile",
              ".gitignore", ".rgignore"
  },
  command = [[%s/\s\+$//e]],
})

require('plugins')

-- configure plugins
require('keys')
require('bookmarks-config')
require('lspconfig-config')
require('rust-tools-config')
require('mason-config')
require('cmp-config')
require('nvim-treesitter-config')
require('trouble-config')
require('mason-lspconfig')
require('maven-config')

-- gui
require('nvim-tree-config')
require('lualine-config')
require('nightfox-config')
require('telescope-config')
require('hop-config')

-- ai
require('cmp-ai-config')
require('minuet-config')

-- org
require('orgmode-config')

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])


