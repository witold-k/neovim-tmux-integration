local doExecute = true -- false for debugging

-- Funktion, um den Pfad der aktuellen Lua-Datei zu ermitteln
local function get_current_file_path()
    local info = debug.getinfo(1, "S")
    return info.source:match("@(.*)$")
end

local function get_nvim_count()
    local handle = io.popen("pgrep -x -c nvim 2>/dev/null")
    if not handle then return 0 end

    local result = handle:read("*a")
    handle:close()

    local count = tonumber(result:match("%d+"))
    return count or 0
end

-- Pfad der aktuellen Datei ermitteln
local currentFilePath = get_current_file_path()

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

local attr = lfs.attributes(conf.runtime_nvim)
if (attr == nil) or (attr.mode ~= "directory") then
    lfs.mkdir(conf.runtime_nvim)
end

-- start neovim in tmux and opt in docker/podman

local pipepath = nil
local cwd = lfs.currentdir()
local cmd_front = 'tmux send-keys -t ide C-m \"'
local cmd_mid = nil
local cmd_tail = nil
if cwd:find("encapsulated") then
    pipepath = conf.runtime_nvim .. '/ide-enc.pipe'
    cmd_mid = conf.config.docker_path .. ' run -it ' ..
        conf.eenv .. ' ' .. rundocker.map(conf.runtime_nvim)  ..
        conf.config.image
    cmd_tail = ' \\"' .. conf.config.nvim_path .. ' --listen ' .. pipepath .. '\\"\" C-m'
else
    pipepath = conf.runtime_nvim .. '/ide.pipe'
    cmd_mid = conf.env
    cmd_tail = ' ' .. conf.config.nvim_path .. ' --listen ' .. pipepath .. '\" C-m'
end
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
if get_nvim_count() == 0 then
    print("delete: " .. nvim_state)
    pdir.rmtree(nvim_state)
end
