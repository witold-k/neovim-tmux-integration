local home = os.getenv("HOME")
local config = home .. '/.config/nvim'

package.path = package.path .. ';' .. config .. '/?.lua'

require('plugins')

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
              "CMake*.txt", "*.cmake",
              "*.java", "*.lua", "*.py", "*.sh", "*.el",
              "*.xml", "*.html",
              "*.bb", "*.bbclass",
              "*.dts", "*.dtsi",
              "**.md", "*.inc",
              "Dockerfile", "Justfile", "Makefile",
              ".gitignore", ".rgignore"
  },
  command = [[%s/\s\+$//e]],
})

-- configure plugins
require('keys')
require('bookmarks-config')
require('lspconfig-config')
require('lualine-config')
require('nightfox-config')
require('nvim-tree-config')
require('telescope-config')
require('rust-tools-config')
require('mason-config')
-- require('cmp-config')
require('nvim-treesitter-config')
require('trouble-config')
require('lspconfig-jdtls-config')
require("mason-lspconfig").setup()

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- require('orgmode-config')
