return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css",
      },
    },
  },
  {
    "preservim/nerdcommenter",
    event = "VeryLazy",
    config = function()
      require("custom.configs.nerdcommenter").setup()
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false, -- Use the latest version
    config = function()
      require("custom.configs.minitrailspace").setup()
    end,
  },
}
