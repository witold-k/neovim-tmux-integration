local function add(path)
  if not string.find(package.path, path, 1, true) then
    package.path = package.path .. ";" .. path
  end
end

local function add_c(path)
  if not string.find(package.cpath, path, 1, true) then
    package.cpath = package.cpath .. ";" .. path
  end
end

local version = _VERSION:match("Lua (%d+%.%d+)")

add("/usr/local/share/lua/" .. version .. "/?.lua")
add("/usr/local/share/lua/" .. version .. "/?/init.lua")
add_c("/usr/local/lib/lua/" .. version .. "/?.so")

local path = require('pl.path')
local nvim_path = vim.loop.exepath()
local nvim_lua  = path.normpath(nvim_path .. '/../../../share/nvim/runtime/lua') .. '/?.lua'
package.path = package.path .. ';' .. nvim_lua


