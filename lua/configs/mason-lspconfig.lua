local lspconfig = require "lspconfig"

-- which of your lspconfig servers to skip installing
local ignore_install = {}

local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "biome",
    "eslint",
    "gopls",
    "ruby_lsp",
    "rust_analyzer",
    "pyright",
    "hyprls",
    "marksman",
    -- "markdown-oxide", -- Disabled to avoid conflicts with marksman
    "harper_ls",
  },
  automatic_installation = {
    exclude = ignore_install,
  },
}

-- Ensure all other servers are filtered
require("mason-lspconfig").setup_handlers {
  function(server_name)
    if not vim.tbl_contains(ignore_install, server_name) then
      require("lspconfig")[server_name].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  end,
}
