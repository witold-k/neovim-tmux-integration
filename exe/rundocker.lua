local lfs = require "lfs"
local pl_path = require("pl.path")

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
    local home = pl_path.expanduser("~")
    local user = os.getenv("USER") or os.getenv("USERNAME")
    local cfp = get_current_file_path()
    local localPath = cfp:sub(1, cfp:find("/[^/]*$") - 1)

    local m =
        map(cwd) .. ' ' ..
        map('/lib/', true) .. ' ' ..
        map('/opt/', true) .. ' ' ..
        map(home .. '/.config/nvim', true) .. ' ' ..
        map(runtime_nvim) .. ' '
    local linked_config = home .. '/svn/other/other/config/files/nvim'
    if exists(linked_config) then
        m = m .. map(runtime_nvim) .. ' '
    end
    m = m .. " -e SYSTEM_UID=" ..  get_user_id() ..
        "-e SYSTEM_NAME=" .. user

    m = ' -v ' .. localPath .. '/entrypoint.sh:/entrypoint.sh '
    m = m .. '--userns=keep-id '

    m = m .. '--entrypoint /entrypoint.sh '

    return m
end

M = {
    map = map_volumes_user
}

return M
