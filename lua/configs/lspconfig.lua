local nv_on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- wrap NVChad’s on_attach to remove that default <leader>ra binding
local on_attach = function(client, bufnr)
  nv_on_attach(client, bufnr)
  vim.keymap.del("n", "<leader>ra", { buffer = bufnr })
end

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"
local mod_cache
local add_ruby_deps_command = require "configs.functions.ruby_deps"

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

  -- Go
  gopls = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gotmpl", "gowork" },
    single_file_support = true,
    root_dir = function(fname)
      -- see: https://github.com/neovim/nvim-lspconfig/issues/804
      if not mod_cache then
        local result = vim.lsp.util.run_command { "go", "env", "GOMODCACHE" }
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
        analyses = { unusedparams = true },
        completeUnimported = true,
        usePlaceholders = true,
        staticcheck = true,
      },
    },
  },

  -- Ruby LSP (with Rails & RSpec add-ons)
  ruby_lsp = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      add_ruby_deps_command(client, bufnr)
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

  -- TypeScript / JavaScript
  ts_ls = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
    },
    root_dir = util.root_pattern("tsconfig.json", "package.json", ".git"),
    settings = {},
  },

  -- Biome (alternative JS/TS linter & formatter)
  biome = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      workspace = {
        didChangeWatchedFiles = { dynamicRegistration = true },
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
  },

  -- Hypr configuration language
  hyprls = {
    cmd = { "hyprls" },
    filetypes = { "hyprlang" },
    root_dir = function()
      return vim.fn.getenv "HOME" .. "/.config/hypr"
    end,
    settings = {},
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
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      workspace = {
        didChangeWatchedFiles = { dynamicRegistration = true },
      },
    }),
  },
}

for name, opts in pairs(servers) do
  local cfg = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }, opts)
  lspconfig[name].setup(cfg)
end
