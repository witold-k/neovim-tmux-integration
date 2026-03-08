local lfs = require "lfs"
local pl_path = require("pl.path")
local home = pl_path.expanduser("~")

local function get_current_file_path()
    local info = debug.getinfo(1, "S")
    return info.source:match("@(.*)$")
end

local function exists(path)
    -- File?
    local f = io.open(path, "r")
    if f then
        f:close()
        return true
    end

    -- Directory? (Try open "." inside)
    local d = io.open(path .. "/.", "r")
    if d then
        d:close()
        return true
    end

    return false
end

local function map(path, ro)
    if ro == nil then ro = false end

    if exists(path) then
        return " -v " .. path .. ":" .. path .. (ro and ":ro" or "")
    end

    return ""
end

local function map_home(path, ro)
    if ro == nil then ro = false end

    local hpath = home .. '/' .. path
    if exists(hpath) then
        return " -v " .. hpath .. ":" .. home .. '_loc/' .. path .. (ro and ":ro" or "")
    end

    return ""
end

local function set_env(key)
    local val = os.getenv(key)
    if val == nil then
        return ''
    else
        return '-e ' .. key .. '=' .. val
    end
end

local function get_user_id()
    local handle = io.popen("id -u")
    local uid = "0"
    if handle ~= nil then
        uid = handle:read("*a")
        handle:close()
    end
    if uid then
      uid = uid:match("%d+")
    end
    return uid
end

local function map_volumes_user(runtime_nvim)
    local cwd = lfs.currentdir()
    local user = os.getenv("USER") or os.getenv("USERNAME")
    local cfp = get_current_file_path()
    local localPath = cfp:sub(1, cfp:find("/[^/]*$") - 1)
    local path = os.getenv('PATH')

    local m =
        map(cwd) .. ' ' ..
        map('/lib/', true) .. ' ' ..
        map('/opt/', true) .. ' ' ..
        map('/usr/', true) .. ' ' ..
        map('/usr/lib/lua/', true) .. ' ' ..
        map('/usr/share/lua/', true) .. ' ' ..
        map('/usr/local/share/lua/', true) .. ' ' ..
        map('/usr/local/lib/lua/', true) .. ' ' ..
        map_home('.config/nvim', true) .. ' ' ..
        map_home('.local/share/nvim', true) .. ' ' ..
        map(home .. '/svn/other/other/config/files/nvim', true) .. ' ' ..
        map(runtime_nvim) .. ' '
    m = m .. '--network host '
    m = m .. '--tmpfs ' .. home .. '_loc/.local/state:rw,size=100M'
    m = m
        .. " -e SYSTEM_UID=" .. get_user_id()
        .. " -e SYSTEM_NAME=" .. user
        .. " -e SYSTEM_PATH=" .. path .. ' '

    m = m .. set_env('RUSTUP_HOME') .. ' ' .. set_env('CARGO_HOME')
    m = m .. set_env('PYTHONPATH')

    m = m .. ' -v ' .. localPath .. '/entrypoint.sh:/entrypoint.sh '
    m = m .. '--userns=keep-id --user root:root '
    m = m .. '--workdir ' .. cwd
    m = m .. ' --entrypoint /entrypoint.sh '

    return m
end

M = {
    map = map_volumes_user
}

return M
