return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  opts = {
    keys = {
      {
        ">",
        function()
          require("quicker").expand { before = 2, after = 2, add_to_existing = true }
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },
    },
    constrain_cursor = true,
    follow = {
      enabled = true,
      center = true,
    },
    highlight = {
      lsp = true,
      load_buffers = true,
    },
    edit = {
      enabled = true,
      autosave = "auto",
    },
    borders = {
      vert = "│",
      -- Strong headers separate results from different files
      strong_header = "━",
      strong_cross = "┿",
      strong_end = "┷",
      -- Soft headers separate results within the same file
      soft_header = "╌",
      soft_cross = "┼",
      soft_end = "┴",
    },
  },
}
