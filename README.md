# Neovim + tmux integration

A personal development environment built around **Neovim running inside tmux**.

The setup starts Neovim as a persistent server inside a tmux session and provides helper commands for opening files in that running instance. The repository also contains the Neovim configuration used for day-to-day software development, including LSP support, completion, debugging, project navigation, Git integration, build output handling, and several language-specific tools.

This is primarily my own working setup rather than a generic Neovim distribution. It contains assumptions about my Linux environment and development workflow, but it can also serve as a reference for building a lightweight terminal-based IDE.

## What it provides

The setup combines:

- **tmux** as the outer terminal workspace
- **Neovim** as a persistent editor/server
- **Lazy.nvim** for plugin management
- **Mason** and **nvim-lspconfig** for language servers
- **nvim-cmp** for completion
- **nvim-dap** for debugging
- **Treesitter** for syntax-aware editing
- **Telescope** and **nvim-tree** for navigation
- **Trouble** for diagnostics and quickfix output
- **Fugitive** and **Diffview** for Git workflows
- **Orgmode** and Markdown rendering
- **Rust**, **Java/Maven**, **C/C++**, **Python**, **Julia**, **Lua**, **LaTeX**, **OpenCL**, and other LSP configurations
- optional **Avante** integration for AI-assisted editing

The configuration also contains project helpers for workflows based on:

- Cargo
- Just
- Make
- GCC
- BitBake

## Architecture

The main workflow is:

1. `nide` starts a tmux session named `ide` if one does not already exist.
2. Neovim is started inside that session with a local server socket.
3. A second tmux pane is created for shell/build commands.
4. `ned <file>` sends files to the already running Neovim instance instead of starting another editor.
5. `ned <file>:<line>[:<column>]` also moves the cursor to the requested position.

The helper scripts are installed into `~/bin` as symbolic links.

## Repository layout

- `plugins/` - Neovim configuration and plugin setup
- `exe/` - launcher and helper scripts such as `nide` and `ned`
- `etc/_tmux.conf` - tmux configuration used with the setup
- `setup.sh` - main installer
- `setup_as_root.sh` - installs system packages
- `setup_lua.sh` - installs Lua dependencies
- `setup_plugins.sh` - links Neovim config and helper commands
- `reinstall.sh` - removes the current Neovim config/state and installs again

## Requirements

The installation scripts currently assume a **Debian-like Linux distribution** with:

- `apt`
- `sudo`
- Bash

The setup installs or expects tools including:

- Neovim
- tmux
- Lua 5.1
- Lua 5.4
- LuaRocks

The completion setup also expects the `just` command to be available.

Some plugins and language servers require additional development tools depending on the languages you use.

## Installation

Clone the repository and run:

```sh
./setup.sh
```

The installer:

- installs missing system dependencies through `apt`
- installs required Lua rocks
- links the files from `plugins/` into `~/.config/nvim/`
- links helper commands from `exe/` into `~/bin/`

Make sure `~/bin` is part of your `PATH`.

For example:

```sh
export PATH="$HOME/bin:$PATH"
```

## tmux configuration

The repository contains an example configuration in:

```text
etc/_tmux.conf
```

In particular, the setup expects a 256-color terminal configuration such as:

```tmux
set -g default-terminal "screen-256color"
```

The supplied configuration also changes the tmux prefix from `Ctrl-b` to `Ctrl-a`, enables mouse support, configures copy mode, and contains a few workflow-specific bindings.

It is best treated as a reference and merged with your existing `~/.tmux.conf` rather than copied blindly.

## Running

Start the development environment with:

```sh
nide
```

Open a file in the running Neovim instance:

```sh
ned path/to/file
```

Open a file and jump to a line:

```sh
ned path/to/file:42
```

Open a file and jump to a line and column:

```sh
ned path/to/file:42:8
```

The `ned` command switches tmux back to the editor pane after opening the file.

## First run

On the first Neovim launch, Lazy.nvim installs the configured plugins.

Plugin management can be opened manually with:

```vim
:Lazy
```

Mason is configured to install several language servers automatically, including:

- clangd
- cmake
- jdtls
- jsonnet_ls
- julials
- lua_ls
- marksman
- mesonlsp
- opencl_ls
- pyright
- ruff
- rust_analyzer
- texlab
- yamlls

You can inspect or manage them with:

```vim
:Mason
```

## Reinstalling

`reinstall.sh` removes the current Neovim configuration and local Neovim data before running the setup again:

```sh
./reinstall.sh
```

Be careful: this removes:

```text
~/.config/nvim
~/.local/share/nvim
```

## Notes and limitations

This repository is intentionally opinionated and still contains environment-specific configuration.

Examples include:

- Debian/`apt` assumptions
- paths under the user's home directory
- project-specific Python path handling
- Docker/Podman integration
- build-system-specific helpers
- language servers and plugins selected for my own work

Because of that, the repository should currently be considered a **personal development environment and reference setup**, not a portable Neovim distribution.

## Useful references

- [Neovim documentation](https://neovim.io/doc/)
- [Neovim quick reference](https://neovim.io/doc/user/quickref.html)
- [tmux documentation](https://github.com/tmux/tmux/wiki)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason](https://github.com/mason-org/mason.nvim)

## License

See [LICENSE](LICENSE).
