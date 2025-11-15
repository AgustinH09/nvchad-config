local keys = {
  -- Global format toggle
  {
    "<leader>tF",
    function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      local status = vim.g.disable_autoformat and "OFF" or "ON"
      vim.notify("Autoformat on save is " .. status .. " (global)", vim.log.levels.INFO)
    end,
    desc = "Toggle autoformat globally",
  },

  -- Buffer-specific format toggle
  {
    "<leader>tf",
    function()
      vim.b.disable_autoformat = not vim.b.disable_autoformat
      local status = vim.b.disable_autoformat and "OFF" or "ON"
      vim.notify("Autoformat on save is " .. status .. " (buffer)", vim.log.levels.INFO)
    end,
    desc = "Toggle autoformat for buffer",
  },

  -- Format current buffer
  {
    "<leader>Ff",
    function()
      require("conform").format({ async = true, lsp_fallback = true }, function(err)
        if not err then
          vim.notify("Formatted buffer", vim.log.levels.INFO)
        end
      end)
    end,
    desc = "Format buffer",
  },

  -- Format selection (visual mode)
  {
    "<leader>Fs",
    function()
      require("conform").format {
        async = true,
        lsp_fallback = true,
        range = {
          start = vim.api.nvim_buf_get_mark(0, "<"),
          ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
        },
      }
    end,
    mode = { "v", "x" },
    desc = "Format selection",
  },

  -- Choose formatter
  {
    "<leader>Fc",
    function()
      require("conform").format {
        formatters = vim.fn.input("Formatter: "):split " ",
        async = true,
      }
    end,
    desc = "Choose formatter",
  },

  -- Show formatter info
  {
    "<leader>Fi",
    "<cmd>ConformInfo<cr>",
    desc = "Show formatter info",
  },
}

return keys
