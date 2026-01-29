#!/usr/bin/lua
-- #!/usr/bin/env lua

local os = require('os')
local uv = require('luv')
local tmpfile = os.tmpname()

local handle = io.popen("id -u")
local uid = "0"
if handle ~= nil then
    uid = handle:read("*a")
    handle:close()
end
if uid then
  uid = uid:match("%d+")
end

-- Write stdin (tmux will pipe the copied text here) into the file
local fh = io.open(tmpfile, "w")
if fh ~= nil then
  for line in io.lines() do
    fh:write(line)
  end
  fh:close()
end

local argv = {
  "nvim",
  "--server", "/run/user/" .. uid .. "/nvim/ide.pipe",
  "--remote-send",
  string.format("<C-\\><C-n>:call setreg('t', readfile(\"%s\")) | call delete(\"%s\")<CR>", tmpfile, tmpfile)
}

-- handle, err = uv ...
local _, _ = uv.spawn(argv[1], { args=argv }, function(_, _) -- code, signal
  -- exit callback: nothing to do here
end)
uv.run()
