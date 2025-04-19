return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = "openai",
    cursor_applying_provider = "openai",
    behaviour = {
      enable_cursor_planning_mode = true,
    },
    gemini = {
      model = "gemini-1.5-pro",
      max_tokens = 2097152,
      -- models:
      -- 1.5-pro: gemini-1.5-pro, max_tokens=2097152
      -- 1.5-flash: gemini-1.5-flash, max_tokens=1048576
      -- 2.0-flash: gemini-2.0-flash, max_tokens=1048576
    },
    openai = {
      model = "gpt-4.1-2025-04-14",
      -- models:
      -- o1: o1-2024-12-17,
      -- o1-mini: o1-mini-2024-09-12
      -- 4-turbo: gpt-4-turbo-2024-04-09,
      -- 3.5-turbo: gpt-3.5-turbo-2024-04-09
      max_tokens = 32768,
      temperature = 0.7,
      timeout = 50000,
    },
    behaviour = {
      auto_suggestions = true, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      enable_token_counting = true, -- Whether to enable token counting. Default to true.
      enable_cursor_planning_mode = true, -- Whether to enable Cursor Planning Mode. Default to false.
      enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
    },
    web_search_engine = {
      provider = "tavily",
      -- provider = "google",
      proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
    },
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub:get_active_servers_prompt()
    end,
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
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
