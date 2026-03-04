return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    input = {
      provider = "snacks",
    },
    -- add any opts here
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",
    -- for example
    provider = "local_llama",
    providers = {
      -- to check models: curl http://127.0.0.1:8080/v1/models
      local_llama = {
        __inherited_from = "openai",
        endpoint = "http://127.0.0.1:8080",
        model = "Meta-Llama-3.1-8B-Instruct-Q5_K_M.gguf",
        api_key_name = "",
        api_key = "",
      },
      ollama = {
        __inherited_from = "ollama",
        endpoint = "http://localhost:11434",
        model = "qwen2.5:32b",
        -- temperature = 0.5,
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet", -- Oder "claude-3-5-sonnet"
        timeout = 30000, -- Timeout in Millisekunden
        extra_request = {
          temperature = 0,
          max_tokens = 4096,
        }
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
