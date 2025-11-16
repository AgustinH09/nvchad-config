local nv_on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- Diagnostic signs
local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

-- Enhanced diagnostic configuration with signs
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    source = "if_many",
    spacing = 4,
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    format = function(diagnostic)
      if diagnostic.source == "harper_ls" then
        return string.format("[grammar] %s", diagnostic.message)
      end
      return diagnostic.message
    end,
  },
  float = {
    source = true,
    border = "rounded",
    header = "",
    prefix = "",
    format = function(diagnostic)
      return string.format("%s: %s", diagnostic.source or "LSP", diagnostic.message)
    end,
  },
  signs = {
    text = signs,
    linehl = {},
    numhl = {},
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- Signs are now configured via vim.diagnostic.config above

-- Show all diagnostics on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

-- wrap NVChad’s on_attach to remove that default <leader>ra binding
local on_attach = function(client, bufnr)
  nv_on_attach(client, bufnr)
  pcall(vim.keymap.del, "n", "<leader>ra", { buffer = bufnr }) -- Safe delete

  if client:supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(true, { buffer = bufnr })
  end

  if client:supports_method "textDocument/semanticTokens" then
    vim.hl.priorities.semantic_tokens = 95
  end
end

-- local marksman_caps = vim.deepcopy(capabilities)
-- marksman_caps.workspace = vim.tbl_extend("force", marksman_caps.workspace, {
--   workspaceFolders = false,
-- })

local servers = {
  -- simple defaults
  cssls = {},
  eslint = {},
  harper_ls = {},
  html = {},
  hypr_ls = {},
  jsonls = {},
  terraformls = {},
  yamlls = {},

  -- Bash language server
  bashls = {
    filetypes = { "sh", "bash", "zsh" },
  },

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
        gofumpt = true,
      },
    },
  },

  -- Ruby LSP
  ruby_lsp = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      require "configs.functions.ruby_deps"(client, bufnr)
      on_attach(client, bufnr)
    end,
    init_options = {
      -- formatter = "standard",
      -- linters = { "standard" },
      formatter = "rubocop",
      linters = { "rubocop" },
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
  },

  -- Biome
  biome = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
  },

  -- Markdown
  -- marksman = {
  --   capabilities = marksman_caps,
  --   filetypes = { "markdown" },
  --   single_file_support = true,
  -- },
  --

  -- markdown_oxide - For Obsidian
  markdown_oxide = {
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }),
    filetypes = { "markdown" },
    root_dir = util.root_pattern(".obsidian", ".git", "README.md"),
  },
}

for name, opts in pairs(servers) do
  local server_opts = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }, opts)

  if vim.fn.has "nvim-0.11" == 1 then
    vim.lsp.config(name, server_opts)
    vim.lsp.enable(name)
  else
    lspconfig[name].setup(server_opts)
  end
end
