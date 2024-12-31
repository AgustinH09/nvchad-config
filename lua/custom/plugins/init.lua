local plugins = {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- Uncomment for format on save
    opts = require "custom.configs.conform", -- Use custom configs
  },
  -- LSPConfig Plugin
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "custom.configs.lspconfig" -- Use custom configs
    end,
  },
  -- Treesitter Plugin
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
    "custom/trim_spaces", -- Dummy entry, no actual plugin, used for organizing config loading
    config = function()
      require("custom.configs.trim_spaces").setup()
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
   
return plugins

