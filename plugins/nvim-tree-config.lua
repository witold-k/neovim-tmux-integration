--
-- git clone --filter=blob:none --sparse http://github.com/ryanoasis/nerd-fonts
-- cd nerd-fonts
-- git sparse-checkout add patched-fonts/BitstreamVeraSansMono

local Api  = require "nvim-tree.api"
local Path = require "plenary.path"
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function tmux_ch_dir()
    local node = Api.tree.get_node_under_cursor()
    local path = Path:new(node.absolute_path)
    if (not path:is_dir()) then
        path = path:parent()
    end

    os.execute("tmux send-keys -t 1 C-c")
    local cmd = "tmux send-keys -t 1 'cd " .. path.filename .. "' Enter"
    os.execute(cmd)
end

-- empty setup using defaults
-- require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
 sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "H", action = "cd" },
        { key = "Y", action = "chdir_tmux", action_cb = tmux_ch_dir },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
