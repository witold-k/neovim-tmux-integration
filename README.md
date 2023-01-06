# Neovim Tmux integration

a simple neovim tmux integration.
also appendend te following neovim plugins:

    - bookmarks
    - lualine
    - nightfox
    - nvim-tree
    - orgmode
    - telescope

for proper key behaviour (Home/End key) be sure to
configure tmux `tmux.conf` with:
```
    set -g default-terminal "screen-256color"
```

# Installation

just execute ./setup.sh in this directory.
This install script is written for debian like linux distributions
that are using the `apt` command to install packages.

# Run

- be sure $HOME/bin is in your `PATH`
- execute `nide` to start the neovim ide
- execute `ned <filename>` to edit a file
- execute `ned <filename>:row[:column]` to edit a file and jump to a position

