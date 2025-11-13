-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",
}

-- Mason packages to install
M.mason = {
  pkgs = {
    -- LSP servers
    "lua-language-server",
    "typescript-language-server",
    "biome",
    "eslint-lsp",
    "gopls",
    "ruby-lsp",
    "rust-analyzer",
    "pyright",
    "hyprls",
    "marksman",
    "harper-ls",

    -- Formatters
    "prettier",
    "stylua",
    "gofumpt",
    "goimports",
    "rubocop",
    "black",
    "isort",
    "shfmt",

    -- Linters
    "golangci-lint",
    "eslint_d",
    "shellcheck",
    "actionlint",

    -- DAP adapters
    "debugpy",
    "delve",
    "codelldb",
    "cpptools",
    "js-debug-adapter",
    "python",
  },
}

M.plugins = {
  ["nvim-telescope/telescope.nvim"] = {
    override_options = function()
      return {
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            height = 0.05,
            prompt_position = "top",
            vertical = {
              mirror = true,
              preview_cutoff = 0,
            },
          },
        },
      }
    end,
  },
}
return M
