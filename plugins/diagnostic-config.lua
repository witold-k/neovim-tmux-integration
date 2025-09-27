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
    virtual_text = true,
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

