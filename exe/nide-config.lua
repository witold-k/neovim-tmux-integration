local config = {
    goproxy = 'https://goproxy.io,direct',
    python_path = '$HOME/svn/buildscripts/python',
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

