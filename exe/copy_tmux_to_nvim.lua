#!/usr/bin/lua
-- #!/usr/bin/env lua

local os = require('os')
local uv = require('luv')
local tmpfile = os.tmpname()

-- Write stdin (tmux will pipe the copied text here) into the file
local fh = io.open(tmpfile, "w")
for line in io.lines() do
  fh:write(line, "\n")
end
fh:close()

local argv = {
  "nvim",
  "--server", "/run/user/1000/nvim/ide.pipe",
  "--remote-send",
  string.format("<C-\\><C-n>:call setreg('t', readfile(\"%s\")) | call delete(\"%s\")<CR>", tmpfile, tmpfile)
}

-- handle, err = uv ...
local _, _ = uv.spawn(argv[1], { args=argv }, function(_, _) -- code, signal
  -- exit callback: nothing to do here
end)
uv.run()
