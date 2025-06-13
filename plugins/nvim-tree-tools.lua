_G.vim = vim -- make checker happy

local Path = require "plenary.path"
local Nvimtree = require "nvim-tree.api"

local M = {}

function M.nvim_tree_dir()
    local node = Nvimtree.tree.get_node_under_cursor()
    if (not node) then
        -- vim.notify("node is nil", vim.log.levels.ERROR)
        return vim.fn.getcwd()
    end

    local path = Path:new(node.absolute_path)
    if (not path) then
        -- vim.notify("path is nil", vim.log.levels.ERROR)
        return vim.fn.getcwd()
    end

    if (not path:is_dir()) then
        path = path:parent()
    end
    if (not path) then
        -- vim.notify("path is nil", vim.log.levels.ERROR)
        return vim.fn.getcwd()
    end

    local pathstr = tostring(path)
    if (not vim.loop.fs_stat(pathstr)) then
        return vim.fn.getcwd()
    end
    -- vim.notify("path is: " .. path, vim.log.levels.ERROR)
    return pathstr
end

return M
