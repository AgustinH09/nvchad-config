require("nvchad.configs.lspconfig").defaults()
-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_attach = require("nvchad.configs.lspconfig").on_attach
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
local on_attach = function(client, bufnr)
  nv_on_attach(client, bufnr)
  vim.keymap.del("n", "<leader>ra", { buffer = bufnr })
end

local lspconfig = require "lspconfig"

-- list of all servers configured.
lspconfig.servers = {
  "cssls",
  "eslint",
  "harper_ls",
  "html",
  "marksman",
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
  single_file_support = true,
  root_dir = function(fname)
    -- see: https://github.com/neovim/nvim-lspconfig/issues/804
    if not mod_cache then
      local result = async.run_command { "go", "env", "GOMODCACHE" }
      if result and result[1] then
        mod_cache = vim.trim(result[1])
      else
        mod_cache = vim.fn.system "go env GOMODCACHE"
      end
    end
    if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
      local clients = vim.lsp.get_clients { name = "gopls" }
      if #clients > 0 then
        return clients[#clients].config.root_dir
      end
    end
    return util.root_pattern("go.work", "go.mod", ".git")(fname)
  end,
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

-- ruby_lsp
lspconfig.ruby_lsp.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
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
  single_file_support = true,
  init_options = {
    ["Ruby LSP Rails"] = {
      enablePendingMigrationsPrompt = false,
    },
    ["Ruby LSP Rspec"] = {
      rspecCommand = "rspec -f d",
    },
    enabledFeatures = { "documentSymbols" },
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

lspconfig.markdown_oxide.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    on_attach(client, bufnr)
  end,
  capabilities = vim.tbl_deep_extend("force", capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }),
}

lspconfig.biome.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = vim.tbl_deep_extend("force", capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }),
  cmd = { "biome", "lsp-proxy" },
  filetypes = {
    "astro",
    "css",
    "graphql",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "svelte",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  single_file_support = false,
}

lspconfig.hyprls.setup {
  cmd = { "hyprls" },
  filetypes = { "hyprlang" },
  root_dir = function()
    return vim.fn.getenv "HOME" .. "/.config/hypr"
  end,
  settings = {},
  on_attach = on_attach,
}
