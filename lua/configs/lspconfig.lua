require("nvchad.configs.lspconfig").defaults()
-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_attach = require("nvchad.configs.lspconfig").on_attach
-- FILE: lua/configs/lspconfig.lua --
local nv_on_attach = require("nvchad.configs.lspconfig").on_attach
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
-- wrap NVChad’s on_attach to remove that default <leader>ra binding
local on_attach = function(client, bufnr)
  nv_on_attach(client, bufnr)
  vim.keymap.del("n", "<leader>ra", { buffer = bufnr })
end

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local marksman_caps = vim.deepcopy(capabilities)
marksman_caps.workspace = vim.tbl_extend("force", marksman_caps.workspace, {
  workspaceFolders = false,
})

-- Define all servers and only specify the bits that differ from the default
local servers = {
  -- simple defaults
  cssls = {},
  eslint = {},
  harper_ls = {},
  html = {},
  jsonls = {},

  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { enable = false },
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
  },

  -- Go (Simplified)
  gopls = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true, -- A common and recommended setting
      },
    },
  },

  -- Ruby LSP (with Rails & RSpec add-ons)
  ruby_lsp = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      require "configs.functions.ruby_deps"(client, bufnr)
      on_attach(client, bufnr)
    end,
    init_options = {
      formatter = "standard",
      linters = { "standard" },
      addonSettings = {
        ["Ruby LSP Rails"] = {
          enablePendingMigrationsPrompt = false,
        },
        ["Ruby LSP RSpec"] = {
          rspecCommand = "rspec -f d",
        },
      },
    },
    cmd = { "mise", "exec", "--", "ruby-lsp" },
    settings = {
      ruby = {
        diagnostics = true,
        formatting = true,
        lint = true,
        completion = true,
        ignored_diagnostics = { "Layout/TrailingEmptyLines" },
      },
    },
  },

  -- TypeScript / JavaScript (Corrected Name)
  ts_ls = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
  },

  -- Biome (alternative JS/TS linter & formatter)
  biome = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
  },

  -- Hypr configuration language
  hyprls = {
    -- lspconfig defaults are sufficient here
  },

  -- Markdown
  marksman = {
    capabilities = marksman_caps,
  },

  markdown_oxide = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
  },
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
-- list of servers configured with default config.
local default_servers = {}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup {
for name, opts in pairs(servers) do
  local server_opts = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }, opts)

  lspconfig[name].setup(server_opts)
end
