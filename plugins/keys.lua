--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap
-- https://neovim.io/doc/user/api.html#nvim_set_keymap()
-- nvim_set_keymap({mode}, {lhs}, {rhs}, {*opts}) nvim_set_keymap() Sets a global mapping for the given mode.


-- remap the key used to leave insert mode
map('i', 'jk', '', {})

-- https://github.com/nvim-tree/nvim-tree.lua
-- Toggle nvim-tree
map('n', '<leader>n', [[:NvimTreeToggle<CR>]], {})
map('n', '<leader>t', [[:NvimTreeFindFile<CR>]], {})
