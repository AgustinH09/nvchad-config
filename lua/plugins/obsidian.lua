return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
    -- "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
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
    notes_subdir = "4. Archives", -- Subdirectory for notes
    new_notes_location = "4. Archives", -- Location for new notes

    attachments = {
      img_folder = "Files", -- Folder for image attachments
    },

    -- Settings for daily notes
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "4. Archives/daily-notes",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      default_tags = { "daily-notes" },
      template = "Daily Note",
    },

    -- Key mappings for Obsidian commands
    mappings = {
      -- "Obsidian follow"
      ["<leader>of"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes "obsidian done"
      ["<leader>od"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- -- Create a new newsletter issue
      -- ["<leader>onn"] = {
      --   action = function()
      --     return require("obsidian").commands.new_note("Newsletter-Issue")
      --   end,
      --   opts = { buffer = true },
      -- },
      -- ["<leader>ont"] = {
      --   action = function()
      --     return require("obsidian").util.insert_template("Newsletter-Issue")
      --   end,
      --   opts = { buffer = true },
      -- },
    },

    -- Function to generate note IDs
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Settings for templates
    templates = {
      subdir = "Templates", -- Subdirectory for templates
      date_format = "%Y-%m-%d-%a", -- Date format for templates
      gtime_format = "%H:%M", -- Time format for templates
      tags = "", -- Default tags for templates
    },

    ui = {
      enabled = false,
    },
  },
}
