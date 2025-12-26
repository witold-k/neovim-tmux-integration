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
local lfs = require "lfs"

--

if (doExecute) then os.execute("tmux new-session -d -s ide") end

-- fixme: grep current user id
local runtime_dir = os.getenv("XDG_RUNTIME_DIR")
if not runtime_dir or runtime_dir == '' then runtime_dir = "/tmp" end

local runtime_nvim = runtime_dir .. '/nvim'

local attr = lfs.attributes(runtime_nvim)
if (attr == nil) or (attr.mode ~= "directory") then
    lfs.mkdir(runtime_nvim)
end

local pipepath = runtime_nvim .. '/ide.pipe'
local cmd = 'tmux send-keys -t ide C-m \"' .. conf.env .. ' nvim --listen ' .. pipepath .. '\" C-m'

if (doExecute) then
    os.execute(cmd)
    os.execute("tmux split-window -v -p 25")
    os.execute("tmux attach -t ide")
else
    print('cmd = '.. cmd)
end

-- finally cleanup

local ppath = require("pl.path")
local home = ppath.expanduser("~")
local pdir = require("pl.dir")
local nvim_state = home .. "/.local/state/nvim"
print("delete: " .. nvim_state)
pdir.rmtree(nvim_state)
