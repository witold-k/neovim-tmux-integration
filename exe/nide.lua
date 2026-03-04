local doExecute = true -- false for debugging

-- Funktion, um den Pfad der aktuellen Lua-Datei zu ermitteln
local function getCurrentFilePath()
    local info = debug.getinfo(1, "S")
    return info.source:match("@(.*)$")
end

-- Pfad der aktuellen Datei ermitteln
local currentFilePath = getCurrentFilePath()

-- Pfad zum 'python'-Verzeichnis ermitteln (relativ zum aktuellen Skript)
local localPath = currentFilePath:sub(1, currentFilePath:find("/[^/]*$") - 1)
package.path = localPath .. "/?.lua;" .. package.path

--

local conf = require('nide-config')
local rundocker = require('rundocker')
local lfs = require "lfs"
local pl_path = require("pl.path")
local home = pl_path.expanduser("~")
local in_tmux = os.getenv("TMUX") ~= nil

--

if (doExecute and not in_tmux) then os.execute("tmux new-session -d -s ide") end

-- fixme: grep current user id
local runtime_dir = os.getenv("XDG_RUNTIME_DIR")
if not runtime_dir or runtime_dir == '' then runtime_dir = "/tmp" end

local runtime_nvim = runtime_dir .. '/nvim'

local attr = lfs.attributes(runtime_nvim)
if (attr == nil) or (attr.mode ~= "directory") then
    lfs.mkdir(runtime_nvim)
end

-- start neovim in tmux and opt in docker/podman

local pipepath = nil
local cwd = lfs.currentdir()
local cmd_front = 'tmux send-keys -t ide C-m \"'
local cmd_mid = nil
if cwd:find("encapsulated") then
    pipepath = runtime_nvim .. '/ide-enc.pipe'
    cmd_mid = conf.config.docker_path .. ' run -it ' ..
        conf.eenv .. ' ' .. rundocker.map(runtime_nvim)  ..
        conf.config.image
else
    pipepath = runtime_nvim .. '/ide.pipe'
    cmd_mid = conf.env
end
local cmd_tail = ' ' .. conf.config.nvim_path .. ' --listen ' .. pipepath .. '\" C-m'
local cmd = cmd_front .. cmd_mid .. cmd_tail
print(cmd)

if (doExecute) then
    os.execute(cmd)
    os.execute("tmux split-window -v -p 25")
    os.execute("tmux attach -t ide")
else
    print('cmd = '.. cmd)
end

-- finally cleanup

local pdir = require("pl.dir")
local nvim_state = home .. "/.local/state/nvim"
print("delete: " .. nvim_state)
pdir.rmtree(nvim_state)
