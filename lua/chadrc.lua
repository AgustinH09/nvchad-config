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
    "markdown_oxide",
    -- "marksman", -- Disabled: using markdown_oxide for Obsidian instead
    "harper-ls",
    "terraform-ls",
    "yaml-language-server",
    "bash-language-server",

    -- Formatters
    "prettier",
    "stylua",
    "gofumpt",
    "goimports",
    "goimports-reviser",
    "golines",
    "rubocop",
    "black",
    "isort",
    "shfmt",

    -- Linters
    "golangci-lint",
    "eslint_d",
    "shellcheck",
    "actionlint",
    "htmlhint",
    "stylelint",
    "jsonlint",
    "markdownlint-cli2",

    -- DAP adapters
    "delve",
    "codelldb",
    "js-debug-adapter",
    "ruby-debug-adapter",
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
