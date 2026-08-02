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
        "cmake",
        "jdtls",
        "jsonnet_ls",
        "julials",
        "lua_ls",
        "just",
        "marksman",
        "matlab_ls",
        "mesonlsp",
        "opencl_ls",
        "pyright",
        "ruff",
        "rust_analyzer",
        "texlab",
        "yamlls",
    }
})

