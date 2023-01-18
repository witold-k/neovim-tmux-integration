local map = vim.api.nvim_set_keymap

require('telescope').setup {
    defaults = {
        path_display = {"truncate"},
    }
}

--  <Leader> key is mapped to \ by default

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


vim.keymap.set('n', '<C-F5>', builtin.find_files, {})
vim.keymap.set('n', '<C-F6>', builtin.live_grep, {})
vim.keymap.set('n', '<C-F7>', builtin.buffers, {})
vim.keymap.set('n', '<C-F8>', builtin.help_tags, {})

vim.keymap.set('i', '<C-F5>', builtin.find_files, {})
vim.keymap.set('i', '<C-F6>', builtin.live_grep, {})
vim.keymap.set('i', '<C-F7>', builtin.buffers, {})
vim.keymap.set('i', '<C-F8>', builtin.help_tags, {})
