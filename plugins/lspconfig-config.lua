-- :h diagnostic-signs

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ", -- '', -- or other icon of your choice here, this is just what my config has:
            [vim.diagnostic.severity.WARN] = "󰀪 ", -- '',
            [vim.diagnostic.severity.INFO] = " ", -- '',
            [vim.diagnostic.severity.HINT] = "󰌶 ", -- '󰌵',
        },
    },
    virtual_text = false,
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

local lspconfig = require('lspconfig')

-- c/c++
lspconfig.clangd.setup {
    cmd = {"clangd"},
    filetypes = {"c", "cpp", "cc", "h", "hpp", "hh" },
}

-- Java
lspconfig.jdtls.setup{}

-- Python
lspconfig.pyright.setup{}

lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    ignore = { "E221", "E401", "E402" },
                    maxLineLength = 119
                }
            }
        }
    }
})

-- Lua
lspconfig.lua_ls.setup {}

-- Latex
lspconfig.texlab.setup {}

-- Markdown
lspconfig.marksman.setup {}

-- json
lspconfig.jsonnet_ls.setup {}

