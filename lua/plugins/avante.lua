return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = "gemini",
    gemini = {
      model = "gemini-1.5-pro",
      max_tokens = 2097152,
      -- models:
      -- 1.5-pro: gemini-1.5-pro, max_tokens=2097152
      -- 1.5-flash: gemini-1.5-flash, max_tokens=1048576
      -- 2.0-flash: gemini-2.0-flash, max_tokens=1048576
    },
    openai = {
      model = "gpt-3.5-turbo-0125",
      -- models:
      -- 4o: chatgpt-4o-latest, gpt-4o-2024-08-06, gpt-4o-2024-11-20
      -- 4o-mini: gpt-4o-mini-2024-07-18,
      -- o1: o1-2024-12-17,
      -- o1-mini: o1-mini-2024-09-12
      -- 4o-realtime: gpt-4o-realtime-preview-2024-12-17, gpt-4o-realtime-preview-2024-10-01
      -- 4o-realtime-mini: gpt-4o-realtime-mini-2024-12-17
      -- 4-turbo: gpt-4-turbo-2024-04-09,
      -- 3.5-turbo: gpt-3.5-turbo-2024-04-09
      --
      max_tokens = 200000,
      --temperature = 0.1,
      timeout = 50000,
    },
  },
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

