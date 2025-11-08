return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  enabled = true,
  version = "1.*",
  dependencies = {
    "giuxtaposition/blink-cmp-copilot",
    "Kaiser-Yang/blink-cmp-avante",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
    },
  },
  opts = {
    keymap = { preset = "default" },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      kind_icons = {
        Copilot = "",
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",

        Field = "󰜢",
        Variable = "󰆦",
        Property = "󰖷",

        Class = "󱡠",
        Interface = "󱡠",
        Struct = "󱡠",
        Module = "󰅩",

        Unit = "󰪚",
        Value = "󰦨",
        Enum = "󰦨",
        EnumMember = "󰦨",

        Keyword = "󰻾",
        Constant = "󰏿",

        Snippet = "󱄽",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
      },
    },
    completion = {
      documentation = {
        auto_show = false,
        -- treesitter_highlighting = false,
      },
      ghost_text = {
        enabled = true,
        show_with_menu = false,
        show_without_selection = false,
      },
      trigger = {
        prefetch_on_insert = true,
        show_on_keyword = true,
        show_on_trigger_character = true,
      },
      keyword = { range = "full" },
      list = {
        max_items = 100,
        selection = {
          preselect = false,
          auto_insert = false,
        },
        cycle = { from_bottom = true, from_top = true },
      },
      accept = {
        dot_repeat = true,
        create_undo_point = true,
      },
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if ctx.source_name == "Path" then
                  local dev_icon = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                if ctx.source_name == "Path" then
                  local _, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  return dev_hl or ctx.kind_hl
                end
                return ctx.kind_hl
              end,
            },
          },
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot", "avante" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
          max_items = 5,
          min_keyword_length = 3,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          score_offset = -100,
          opts = {},
        },
        buffer = {
          name = "buffer",
          score_offset = -10,
          max_items = 5,
          min_keyword_length = 4,
        },
        path = {
          name = "path",
          score_offset = 10,
          max_items = 10,
        },
        snippets = {
          name = "snippets",
          score_offset = 0,
          max_items = 10,
        },
        lsp = {
          name = "lsp",
          score_offset = 90,
        },
      },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      max_typos = function(kw)
        if #kw <= 4 then
          return 0
        elseif #kw <= 8 then
          return 1
        else
          return 2
        end
      end,
      frecency = {
        enabled = true,
      },
      use_proximity = true,
    },
    signature = { enabled = true },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = {
        menu = { auto_show = true },
        ghost_text = { enabled = true },
      },
    },
    snippets = { preset = "luasnip" },
  },
  opts_extend = { "sources.default" },
}
