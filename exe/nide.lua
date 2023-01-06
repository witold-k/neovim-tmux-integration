local doExecute = true -- false for debugging

-- Lua
local lfs = require "lfs"

--

if (doExecute) then os.execute("tmux new-session -d -s ide") end

-- fixme: grep current user id
local runtime_dir = os.getenv("XDG_RUNTIME_DIR")
local runtime_nvim = runtime_dir .. '/nvim'

local attr = lfs.attributes(runtime_nvim)
if (attr == nil) or (attr.mode ~= "directory") then
    lfs.mkdir(runtime_nvim)
end

local pipepath = runtime_nvim .. '/ide.pipe'
local cmd = 'tmux send-keys -t ide C-m \"nvim --listen ' .. pipepath .. '\" C-m'

if (doExecute) then
    os.execute(cmd)
    os.execute("tmux split-window -v -p 25")
    os.execute("tmux attach -t ide")
else
    print('cmd = '.. cmd)
end
