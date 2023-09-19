# Neovim Tmux integration

a simple neovim tmux integration for an ide like user experience.
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

This is a minimal setup, code completion and formatting are not
configured here.

# Installation

just execute ./setup.sh in this directory.
This install script is written for debian like linux distributions
that are using the `apt` command to install packages.

# Run

- be sure $HOME/bin is in your `PATH`
- execute `nide` to start the neovim ide
- execute `ned <filename>` to edit a file
- execute `ned <filename>:row[:column]` to edit a file and jump to a position


## First run

to start neovim with tmux just type in console:
```
    nide
```

then install the packages in neovim:
```
    :PackerUpdate
```

after restart neovin install Mason packages:
```
    :MasonInstall codelldb rust-analyzer cpptools lua-language-server cmake-language-server

```

# Links and Hints

- [Neovim editing/navigation](https://neovim.io/doc/user/change.html)
- [Neovim quickref](https://neovim.io/doc/user/quickref.html)
- [Neovim for beginner](https://github.com/alpha2phi/neovim-for-beginner)
- [Video configure neovim](https://www.youtube.com/watch?v=vdn_pKJUda8)

# useful lua extensions

- [package "path"](https://luapower.com/path#path)

