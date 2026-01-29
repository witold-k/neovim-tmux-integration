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
vim.lsp.enable('pyright')

-- Python (pylsp)
vim.lsp.config['pylsp'] = {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          ignore = { "E221", "E241", "E401", "E402", "E722" },
          maxLineLength = 119,
        },
      },
    },
  },
}
vim.lsp.enable('pylsp')

-- Rust

vim.lsp.config["rust_analyzer"] = {}
vim.lsp.enable("rust_analyzer")

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
