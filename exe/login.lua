#!/usr/bin/lua

-- Returns the canonical absolute path of the current Lua file
local function get_current_file_path()
    local info = debug.getinfo(1, "S")
    local source = info.source

    -- Only handle file sources (start with '@')
    if source:sub(1, 1) == "@" then
        local path = source:sub(2)

        -- Normalize to absolute path
        local cwd = io.popen("pwd"):read("*l")  -- works on Linux/macOS
        -- For Windows, replace with: io.popen("cd"):read("*l")

        if path:sub(1, 1) ~= "/" then
            -- relative path -> absolute
            path = cwd .. "/" .. path
        end

        -- Canonicalize (resolve ./ and ../)
        local canon = io.popen("readlink -f " .. path):read("*l")
        return canon or path
    end

    return nil
end


-- Pfad der aktuellen Datei ermitteln
local currentFilePath = get_current_file_path()
print('current file: ' .. currentFilePath)

-- Pfad zum 'python'-Verzeichnis ermitteln (relativ zum aktuellen Skript)
local localPath = currentFilePath:sub(2, currentFilePath:find("/[^/]*$") - 1)
print('local path: ' .. localPath)
package.path = localPath .. "/?.lua;" .. package.path

--

conf = require('nide-config')
rundocker = require('rundocker')

local pipepath = conf.runtime_nvim .. '/ide-enc.pipe'
local cmd_mid = conf.config.docker_path .. ' run -it ' ..
    conf.eenv .. ' ' .. rundocker.map(conf.runtime_nvim)  ..
    conf.config.image
-- local cmd_tail = ' \"' .. conf.config.nvim_path .. ' --listen ' .. pipepath .. '\"'
local cmd_tail = ' bash'
local cmd = cmd_mid .. cmd_tail
print(cmd)
os.execute(cmd)
