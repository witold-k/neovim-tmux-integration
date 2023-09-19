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
  pattern = { "*.h", "*.c", "*.hpp", "*.cpp", "*.rs", "*.in",
              "CMake*.txt", "*.cmake",
              "*.java", "*.lua", "*.py", "*.sh", "*.el",
              "*.bb", "*.bbclass",
              "*.dts", "*.dtsi",
              "**.md", "*.inc",
              "Makefile", "Dockerfile",
  },
  command = [[%s/\s\+$//e]],
})

-- configure plugins
require('keys')
require('bookmarks-config')
require('lualine-config')
require('nightfox-config')
require('nvim-tree-config')
require('telescope-config')
require('rust-tools-config')
require('mason-config')
require('cmp-config')
require('nvim-treesitter-config')
require('trouble-config')

require("mason-lspconfig").setup()

-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- require('orgmode-config')
