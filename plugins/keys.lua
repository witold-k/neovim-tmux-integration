_G.vim = vim -- make lsp checker happy

local Path     = require "plenary.path"
local Nvimtree = require "nvim-tree.api"

local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set

-- https://neovim.io/doc/user/api.html#nvim_set_keymap()
-- nvim_set_keymap({mode}, {lhs}, {rhs}, {*opts}) nvim_set_keymap() Sets a global mapping for the given mode.

local opts = { noremap = true, silent = true }

-- remap the key used to leave insert mode
map('i', 'jk', '', {})

-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)
keymap("v", "p", '"_dP', opts)
keymap("v", "c", '"_c', opts)

-- Normal mode: remap delete to black hole
vim.keymap.set("n", "d", '"_d', opts)
vim.keymap.set("n", "dd", '"_dd', opts)
vim.keymap.set("n", "D", '"_D', opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)


-- https://github.com/nvim-tree/nvim-tree.lua
-- Toggle nvim-tree
map('n', '<leader>n', [[:NvimTreeToggle<CR>]], {})
map('n', '<leader>r', [[:Trouble diagnostics toggle<CR>]], {})
map('n', '<F7>', [[:NvimTreeFindFile<CR>]], {})

-- tmux
local function copy_register_to_tmux(register)
    local yank = vim.fn.getreg(register)
    local cmd = { "tmux",  "set-buffer", "-" }
    local job_id = vim.fn.jobstart(cmd, { stdin = "pipe", detach = true })
    vim.fn.chansend(job_id, yank)
    vim.fn.chanclose(job_id, "stdin")
end

-- selection to tmux
local function copy_visual_to_tmux(yank)
    --[[
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
    --]]
    -- print(vim.inspect(s_start) .. " " .. vim.inspect(s_end))
    --
    local cmd = { "tmux",  "load-buffer", "-" }
    local job_id = vim.fn.jobstart(cmd, { stdin = "pipe", detach = true })
    vim.fn.chansend(job_id, yank)
    vim.fn.chanclose(job_id, "stdin")
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

map('n', '<C-x>', [[ :bp<bar>sp<bar>bn<bar>bd<CR> ]], { })
-- In your Neovim config (init.lua or plugin file)

local registers = {
    '+', '-', '*', '%', '#', '.', ':', '"', '/', '=', '_',
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
    'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
    's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
}

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local ev = vim.v.event
    local regtype = vim.v.event.regtype
    local text = vim.fn.getreg(ev.regname)
    -- Only run for visual yanks if you want
    if regtype:match("[vV]") then
      copy_visual_to_tmux(text)
    end
  end,
})

-- map setup project dir
map('n', '<leader>s', [[ :lua Load_neovim_project_config()<CR> ]], { })
map('v', '<reader>s', [[ :lua Load_neovim_project_config()<CR> ]], { })

-- map setup project dir
map('n', '<leader>b', [[ :make<CR> ]], { })
map('v', '<leader>b', [[ :make<CR> ]], { })

