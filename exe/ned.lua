local doExecute = true -- false for debugging


local Path = require "pl.path"

local runtime_dir = os.getenv("XDG_RUNTIME_DIR")
if not runtime_dir or runtime_dir == '' then runtime_dir = "/tmp" end

local runtime_nvim = runtime_dir .. '/nvim'
local pipepath = runtime_nvim .. '/ide.pipe'

local function splitrowcol(inputstr)
    local t = {}
    for str in string.gmatch(inputstr, "([^:]+)") do
        -- print(str)
        table.insert(t, str)
    end
    return t
end

if (#arg > 0) then
    local filterrowcol = splitrowcol(arg[1])
    local row = 0
    local col = 0
    local filename = ""
    if filterrowcol ~= nil then
        if #filterrowcol > 1 then
            row = filterrowcol[2]
        end
        if #filterrowcol > 2 then
            col = filterrowcol[3]
        end
        filename = filterrowcol[1]
    else
        filename = arg[1]
    end
    filename = Path.abspath(filename)

    local fileargs = { "nvim", "--server", pipepath, "--remote", filename }
    local filestr = table.concat(fileargs, ' ')
    -- print(filestr)
    if (doExecute) then os.execute(filestr) end

    if (col ~= 0) or (row ~= 0) then
        local linecolumn = "'<C-\\><C-N>:eval cursor(" .. row .."," .. col ..")<CR>'"
        local jmpargs = { "nvim", "--server", pipepath, "--remote-send", linecolumn }
        local jmpstr = table.concat(jmpargs, ' ')
        -- print(jmpstr)
        if (doExecute) then os.execute(jmpstr) end
    end

    local tmuxargs = { "tmux", "select-window", "-t", "0", "\\;", "select-pane", "-t", "0" }
    local tmuxstr = table.concat(tmuxargs, ' ')
    -- print(tmuxstr)
    if (doExecute) then os.execute(tmuxstr) end
end

