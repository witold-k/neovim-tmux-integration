_G.vim = vim -- make checker happy

-- local ls = require("luasystem")
local M = {}

function M.set_python_path(script_path)
    local project_dir = tostring(vim.fn.expand(vim.fn.fnamemodify(script_path , ":h:h")))
    local pp = os.getenv('PYTHONPATH')
    if not pp then
        ls.setenv('PYTHONPATH', project_dir .. '/buildscripts/python:' .. project_dir .. '/common-scripts/python')
    else
        if not string.find(pp, 'buildscripts') then
            ls.setenv('PYTHONPATH', pp .. ':' .. project_dir .. '/buildscripts/python')
        end
        if not string.find(pp, 'common-scripts') then
            ls.setenv('PYTHONPATH', pp .. ':' .. project_dir .. '/common-scripts/python')
        end
    end
end

function M.project_setup_cargo_just(script_path)
    -- M.set_python_path(script_path)
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
    -- M.set_python_path(script_path)
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
    -- M.set_python_path(script_path)
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
