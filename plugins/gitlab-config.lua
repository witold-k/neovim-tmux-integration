return {
  "harrisoncramer/gitlab.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
    "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
  },
  build = function () require("gitlab.server").build(true) end, -- Builds the Go binary
  config = function()
    require("gitlab").setup({
      connection_settings = {
        proxy = "", -- Configure a proxy URL to use when connecting to GitLab. Supports URL schemes: http, https, socks5
        insecure = true, -- Like curl's --insecure option, ignore bad x509 certificates on connection
        remote = "origin", -- The default remote that your MRs target
      },
    })
  end,
}

