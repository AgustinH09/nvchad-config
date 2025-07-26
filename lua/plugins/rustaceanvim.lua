return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false, -- This plugin is already lazy
  ft = { "rust" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    local on_attach = require("nvchad.configs.lspconfig").on_attach
    local on_init = require("nvchad.configs.lspconfig").on_init
    local capabilities = require("nvchad.configs.lspconfig").capabilities

    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
        hover_actions = {
          auto_focus = false,
        },
        float_win_config = {
          border = "rounded",
        },
      },
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          -- Disable formatting provided by rust-analyzer
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Call NvChad's on_attach
          on_attach(client, bufnr)

          -- Remove the default <leader>ra binding from NvChad
          vim.keymap.del("n", "<leader>ra", { buffer = bufnr })
        end,
        on_init = on_init,
        capabilities = capabilities,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
              attributes = {
                enable = true,
              },
            },
            diagnostics = {
              enable = true,
              disabled = { "unresolved-proc-macro" },
              enableExperimental = true,
            },
            completion = {
              autoimport = {
                enable = true,
              },
              postfix = {
                enable = true,
              },
              privateEditable = {
                enable = true,
              },
            },
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = true,
              },
              closingBraceHints = {
                enable = true,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = "never",
              },
              lifetimeElisionHints = {
                enable = "never",
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = "never",
              },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
            lens = {
              enable = true,
              run = {
                enable = true,
              },
              debug = {
                enable = true,
              },
              implementations = {
                enable = true,
              },
              references = {
                enable = true,
                adt = {
                  enable = true,
                },
                enumVariant = {
                  enable = true,
                },
                trait = {
                  enable = true,
                },
              },
            },
            hover = {
              actions = {
                enable = true,
                debug = {
                  enable = true,
                },
                gotoTypeDef = {
                  enable = true,
                },
                implementations = {
                  enable = true,
                },
                references = {
                  enable = true,
                },
                run = {
                  enable = true,
                },
              },
              documentation = {
                enable = true,
              },
              links = {
                enable = true,
              },
            },
          },
        },
      },
      -- DAP configuration
      dap = {
        autoload_configurations = true,
      },
    }
  end,
}
