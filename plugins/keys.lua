_G.vim = vim -- make lsp checker happy

local Path     = require "plenary.path"
local Nvimtree = require "nvim-tree.api"

local map = vim.api.nvim_set_keymap
-- https://neovim.io/doc/user/api.html#nvim_set_keymap()
-- nvim_set_keymap({mode}, {lhs}, {rhs}, {*opts}) nvim_set_keymap() Sets a global mapping for the given mode.


-- remap the key used to leave insert mode
map('i', 'jk', '', {})

-- https://github.com/nvim-tree/nvim-tree.lua
-- Toggle nvim-tree
map('n', '<leader>n', [[:NvimTreeToggle<CR>]], {})
map('n', '<leader>r', [[:Trouble diagnostics toggle<CR>]], {})
map('n', '<F7>', [[:NvimTreeFindFile<CR>]], {})
--shell
local function shell_escape(args)
	local ret = {}
	for _,a in pairs(args) do
		local s = tostring(a)
		if s:match("[^A-Za-z0-9_/:=-]") then
			s = "'"..s:gsub("'", "'\\''").."'"
		end
		table.insert(ret,s)
	end
	return table.concat(ret, " ")
end

-- tmux
function copy_register_to_tmux()
    local yank = vim.fn.getreg('"')
    local cmd = { "tmux",  "set-buffer", yank }
    os.execute(shell_escape(cmd))
    -- "tmux paste" for dump buffer content to terminal
end

-- selection to tmux
function copy_visual_to_tmux()
    local s_start = vim.api.nvim_buf_get_mark(0, "<")
    local s_end   = vim.api.nvim_buf_get_mark(0, ">")
    local n_lines = math.abs(s_end[1] - s_start[1]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[1] - 1, s_end[1], false)
    -- print(vim.inspect(s_start[1]) .. " " .. vim.inspect(s_start) .. " " .. vim.inspect(s_end) ..  " " .. vim.inspect(lines))

    lines[1] = string.sub(lines[1], s_start[2] + 1, -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[2] - s_start[2])
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[2])
    end
    local yank = table.concat(lines, '\n')
    -- print(vim.inspect(s_start) .. " " .. vim.inspect(s_end))
    local cmd = { "tmux",  "set-buffer", yank }
    os.execute(shell_escape(cmd))
end

-- setup project dir, configures :makeprg=
-- calling make will build and forward to trouble diagnostics
function Load_neovim_project_config()
    local node = Nvimtree.tree.get_node_under_cursor()
    local path = tostring(Path:new(node.absolute_path)) .. '/.neovim/projectconf.lua'
    print("project path: " .. path)
    dofile(path)
    return path
end

map('n', '<leader>y', [[ :lua copy_register_to_tmux()<CR> ]], { })
map('v', '<leader>y', [[ :lua copy_visual_to_tmux()<CR> ]], { })
map('n', '<C-x>', [[ :bp<bar>sp<bar>bn<bar>bd<CR> ]], { })

-- map setup project dir
map('n', '<leader>s', [[ :lua Load_neovim_project_config()<CR> ]], { })
map('v', '<reader>s', [[ :lua Load_neovim_project_config()<CR> ]], { })

-- map setup project dir
map('n', '<leader>b', [[ :make<CR> ]], { })
map('v', '<leader>b', [[ :make<CR> ]], { })

