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
  pattern = { "*.h*", "*.c*", "*.java", "*.lua", "*.py" },
  command = [[%s/\s\+$//e]],
})

-- configure plugins 
require('keys')
require('bookmarks-config')
require('lualine-config')
require('nightfox-config')
require('nvim-tree-config')
require('telescope-config')

-- require('orgmode-config')
