return {
  "hrsh7th/nvim-cmp",
  enabled = false,
  dependencies = {
    {
      -- snippet plugin
      "L3MON4D3/LuaSnip",
      config = function(_, opts)
        require("luasnip").config.set_config(opts)

        local luasnip = require "luasnip"

        luasnip.filetype_extend("javascriptreact", { "html" })
        luasnip.filetype_extend("typescriptreact", { "html" })
        luasnip.filetype_extend("svelte", { "html" })

        require "nvchad.configs.luasnip"
      end,
    },
    "saadparwaiz1/cmp_luasnip",
    { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "MeanderingProgrammer/render-markdown.nvim",
    "zbirenbaum/copilot.lua",
    "onsails/lspkind.nvim",
    "xzbdmw/colorful-menu.nvim",
  },
  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"

    -- LuaSnip setup
    luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }
    for _, ft in ipairs { "javascriptreact", "typescriptreact", "svelte" } do
      luasnip.filetype_extend(ft, { "html" })
    end
    require "nvchad.configs.luasnip" -- if you still want the nvchad defaults

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert {
        -- Accept the currently selected item (replace the whole word)
        ["<C-y>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },

        -- Cancel completion
        ["<C-e>"] = cmp.mapping.abort(),

        -- Scroll docs
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Tab / S-Tab to navigate + snippet jump
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = "render-markdown", group_index = 2 },
        { name = "nvim_lsp", group_index = 1 },
        { name = "luasnip", group_index = 1 },
      }, {
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
      }),

      formatting = {
        format = lspkind.cmp_format {
          mode = "symbol",
          maxwidth = 50,
          ellipsis_char = "...",
          show_labelDetails = true,
          before = function(entry, vim_item)
            local info = require("colorful-menu").cmp_highlights(entry)
            if info then
              vim_item.abbr = info.text
              vim_item.abbr_hl_group = info.highlights
            end
            return vim_item
          end,
        },
      },

      experimental = {
        ghost_text = true,
      },
    }

    -- cmdline “/” and “?” (search)
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })

    -- cmdline “:”
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      matching = {
        disallow_symbol_nonprefix_matching = false,
      },
    })
  end,
}
