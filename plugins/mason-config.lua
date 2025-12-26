require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "grammarly",
        "cmake",
        "jdtls",
        "jsonnet_ls",
        "lua_ls",
        "marksman",
        "matlab_ls",
        "mesonlsp",
        "pyright",
        "pylsp",
        "rust_analyzer",
        "texlab",
        "yamlls",
    }
})

