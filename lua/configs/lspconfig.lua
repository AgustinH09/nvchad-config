require("nvchad.configs.lspconfig").defaults()
-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = { "html", "cssls" }
vim.lsp.enable(servers)
local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require("lspconfig")
local lspconfig = require("lspconfig")
local lspconfig = require "lspconfig"

-- list of all servers configured.
lspconfig.servers = {
  "cssls",
  "gopls",
  "harper_ls",
  "html",
  "lua_ls",
  "ruby_lsp",
  "ts_ls",
}

-- list of servers configured with default config.
local default_servers = {}

-- read :h vim.lsp.config for changing options of lsp servers 
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
-- lsps with default config
for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- lua_ls
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        enable = false, -- Disable all diagnostics from lua_ls
        -- globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- gopls
lspconfig.gopls.setup {
  -- not use gopls as formater
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
    },
  },
}

-- ruby_ls
lspconfig.ruby_lsp.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "ruby-lsp" },
  filetypes = { "ruby" },
  root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
  settings = {
    ruby = {
      diagnostics = true,
      formatting = false,
      lint = true,
      completion = true,
      ignored_diagnostics = { "Layout/TrailingEmptyLines" },
    },
  },
}

-- tsserver setup
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
  settings = {},
}
