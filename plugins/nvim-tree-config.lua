_G.vim = vim -- make lsp checker happy

-- git clone --filter=blob:none --sparse http://github.com/ryanoasis/nerd-fonts
-- cd nerd-fonts
-- git sparse-checkout add patched-fonts/BitstreamVeraSansMono

local Api  = require "nvim-tree.api"
local Path = require "plenary.path"

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

-- local function open_by_suffix()
--     local node = Api.tree.get_node_under_cursor()
--     local path = Path:new(node.absolute_path)
--     if (not path:is_dir()) then
--         local app = '';
--         local suffix = path.suffix();
--         if (suffix == '.pdf') then app = 'evince'; end
--
--         local cmd = app + '/' + path
--         os.execute(cmd)
--     end
-- end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<F4>', tmux_ch_dir,                     opts('ch dir'))
  vim.keymap.set('n', 'u',    api.tree.change_root_to_parent,  opts('Up'))
  vim.keymap.set('n', '?',    api.tree.toggle_help,            opts('Help'))
end

-- empty setup using defaults
-- require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  on_attach = my_on_attach,
  actions = {
    change_dir = { enable = false }
  },
  view = {
    width = {
        max = 50
    },
  },
  renderer = {
    group_empty = true,
    symlink_destination = false,
  },
  filters = {
    dotfiles = true,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 400,
  },
})
