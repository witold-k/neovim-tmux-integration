_G.vim = vim -- make lsp checker happy

-- https://vimawesome.com/plugin/telescope-nvim-care-of-itself

local ntt = require('nvim-tree-tools')

require('telescope').setup {
    defaults = {
        path_display = {"truncate"},
    },
    pickers = {
        -- Your special builtin config goes in here
        buffers = {
            -- sort_lastused = true,
            -- theme = "dropdown",
            -- previewer = false,
            mappings = {
              i = {
                  ["<c-d>"] = require("telescope.actions").delete_buffer,
                  -- Right hand side can also be the name of the action as a string
                  ["<c-d>"] = "delete_buffer",
              },
              n = {
                  ["<c-d>"] = require("telescope.actions").delete_buffer,
              }
            }
        },
        find_files = {
            --theme = "dropdown",
        }
    },
}

require("telescope").load_extension("yank_history")

--  <Leader> key is mapped to \ by default

local builtin = require('telescope.builtin')

local ff = function()
    local opts = {
        cwd = ntt.nvim_tree_dir(), -- Dynamically set the search directory
        hidden = true, -- Include hidden files
        no_ignore = true, -- Ignore `.gitignore` rules
    }
    builtin.find_files(opts)
    -- vim.notify("path is: " .. nvim_tree_dir(), vim.log.levels.ERROR)
end

local lg = function()
    local opts = {
        cwd = ntt.nvim_tree_dir(), -- Dynamically set the search directory
        hidden = true, -- Include hidden files
        no_ignore = true, -- Ignore `.gitignore` rules
    }
    builtin.live_grep(opts)
end


vim.keymap.set('n', '<leader>ff', ff, {})
vim.keymap.set('n', '<leader>fg', lg, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<C-F5>', ff, {})
vim.keymap.set('n', '<C-F6>', lg, {})
vim.keymap.set('n', '<C-F7>', builtin.buffers, {})
vim.keymap.set('n', '<C-F8>', builtin.help_tags, {})

vim.keymap.set('i', '<C-F5>', ff, {})
vim.keymap.set('i', '<C-F6>', lg, {})
vim.keymap.set('i', '<C-F7>', builtin.buffers, {})
vim.keymap.set('i', '<C-F8>', builtin.help_tags, {})
