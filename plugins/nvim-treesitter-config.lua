M = {
    ensure_installed = {
        "rust", "toml",
        "c", "cpp", "java", "go", "glsl", "vala",
        "python", "javascript", "json", "julia", "r", "lua", "sql",
        "xml", "cmake", "markdown", "meson", "csv", "yaml",
        "make", "just", "zig", "bitbake", "bash", "powershell",
        "gnuplot",
        "verilog", "vhdl"
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = {'org'},
    },
    ident = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
  }

return M
