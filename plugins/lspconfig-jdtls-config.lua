local lspconfig = require('lspconfig')

-- c/c++
lspconfig.clangd.setup {
    cmd = {"clangd"},
    filetypes = {"c", "cpp", "cc", "h", "hpp", "hh" },
}

-- Java
lspconfig.jdtls.setup{}

-- Python
lspconfig.pyright.setup {}

-- Lua
lspconfig.lua_ls.setup {}

-- Latex
lspconfig.texlab.setup {}

-- Markdown
lspconfig.marksman.setup {}

-- json
lspconfig.jsonnet_ls.setup {}


