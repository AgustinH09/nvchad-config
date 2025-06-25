return {
  "obsidian-nvim/obsidian.nvim",
  lazy = true,
  ft = "markdown",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  on_attach = function(bufnr)
    local map = vim.keymap.set
    map("n", "<leader>of", function()
      return require("obsidian").util.gf_passthrough()
    end, {
      expr = true,
      noremap = false, -- Important for this specific mapping
      buffer = bufnr,
      desc = "Obsidian: Follow link under cursor",
    })
    map("n", "<leader>od", function()
      require("obsidian").util.toggle_checkbox()
    end, {
      buffer = bufnr,
      desc = "Obsidian: Toggle checkbox",
    })
  end,
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/github/obsidian/personal",
      },
      -- {
      --   name = "work",
      --   path = "~/github/obsidian/work/",
      -- },
    },

    completion = {
      nvim_cmp = false,
      blink_cmp = true,
      min_chars = 1,
    },
    notes_subdir = "4. Archives",
    new_notes_location = "4. Archives",

    attachments = {
      img_folder = "Files",
    },

    daily_notes = {
      folder = "4. Archives/daily-notes",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily-notes" },
      template = "Daily Note",
    },

    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    templates = {
      subdir = "Templates",
      date_format = "%Y-%m-%d-%a",
      gtime_format = "%H:%M",
      tags = "",
    },

    ui = {
      enabled = false,
    },
  },
}
