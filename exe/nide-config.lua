local path
local python_path = nil

if python_path ~= nil then
    path = '$HOME/svn/buildscripts/python'
    if vim.loop.fs_stat(path) ~= nil then
        python_path = path
    end
end

if python_path ~= nil then
    path = '$HOME/repos/buildscripts/python'
    if vim.loop.fs_stat(path) ~= nil then
        python_path = path
    end
end

if python_path ~= nil then
    path = '$HOME/repos/common-scripts/python'
    if vim.loop.fs_stat(path) ~= nil then
        python_path = path
    end
end

if python_path ~= nil then
    path = '$HOME/depots/common-scripts/python'
    if vim.loop.fs_stat(path) ~= nil then
        python_path = path
    end
end

local config = {
    goproxy = 'https://goproxy.io,direct',
    python_path = python_path,
}

local goproxy_env = 'GOPROXY=https://goproxy.io,direct'
local python_path_env = 'PYTHONPATH=$HOME/svn/buildscripts/python'

return {
    config = config,
    vars = {
        goproxy_env = goproxy_env,
        python_path_env = python_path_env,
    },
    env = goproxy_env .. ' ' .. python_path_env
}

