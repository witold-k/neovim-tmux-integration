_G.vim = vim -- make checker happy

local M = {}

function M.project_setup_cargo_just(script_path)
    local project_dir = tostring(vim.fn.expand(vim.fn.fnamemodify(script_path , ":h:h")))

    -- Automatically open Trouble.nvim when quickfix updates
    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
      pattern = "*",
      callback = function()
        vim.cmd("Trouble quickfix")
      end,
    })

    -- set cargo as the compiler
    vim.api.nvim_command("cd " .. project_dir)
    vim.api.nvim_command("compiler cargo")

    -- define custom make program using 'just'
    -- calling via :make
    vim.o.makeprg = "cd " .. project_dir .. " && just"
end

function M.project_setup_gcc_just(script_path)
    local project_dir = tostring(vim.fn.expand(vim.fn.fnamemodify(script_path , ":h:h")))

    -- Automatically open Trouble.nvim when quickfix updates
    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
      pattern = "*",
      callback = function()
        vim.cmd("Trouble quickfix")
      end,
    })

    -- set cargo as the compiler
    vim.api.nvim_command("cd " .. project_dir)
    vim.api.nvim_command("compiler gcc")

    -- define custom make program using 'just'
    -- calling via :make
    vim.o.makeprg = "cd " .. project_dir .. " && just"
end

function M.project_setup_gcc_make(script_path)
    local project_dir = tostring(vim.fn.expand(vim.fn.fnamemodify(script_path , ":h:h")))

    -- Automatically open Trouble.nvim when quickfix updates
    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
      pattern = "*",
      callback = function()
        vim.cmd("Trouble quickfix")
      end,
    })

    -- set cargo as the compiler
    vim.api.nvim_command("cd " .. project_dir)
    vim.api.nvim_command("compiler gcc")

    -- define custom make program using 'just'
    -- calling via :make
    vim.o.makeprg = "cd " .. project_dir .. " && make"
end

return M
