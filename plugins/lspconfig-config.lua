-- C/C++
vim.lsp.config['clangd'] = {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "cc", "h", "hpp", "hh" },
}
vim.lsp.enable('clangd')

-- Java
vim.lsp.config['jdtls'] = {}
vim.lsp.enable('jdtls')

-- Python (Pyright)
vim.lsp.config['pyright'] = {}
-- Python (ruff)
vim.lsp.config['ruff'] = {}

vim.lsp.enable({ 'ruff', 'pyright' })

-- Rust

vim.lsp.config["rust_analyzer"] = {}
vim.lsp.enable("rust_analyzer")

-- julia
vim.lsp.config['julials'] = {}
vim.lsp.enable('julials')

-- just
vim.lsp.config['just'] = {}
vim.lsp.enable('just')

-- Lua
vim.lsp.config['lua_ls'] = {}
vim.lsp.enable('lua_ls')

-- LaTeX
vim.lsp.config['texlab'] = {}
vim.lsp.enable('texlab')

-- Markdown
vim.lsp.config['marksman'] = {}
vim.lsp.enable('marksman')

-- OpenCL
vim.lsp.config["opencl_ls"] = {
  cmd = { "opencl_ls" },
  filetypes = { "opencl", "cl" },
}
vim.lsp.enable("opencl_ls")

-- JSONNet
vim.lsp.config['jsonnet_ls'] = {}
vim.lsp.enable('jsonnet_ls')


-- general
-- vim.lsp.inlay_hint.enable(true)
