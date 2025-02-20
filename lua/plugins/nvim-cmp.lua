return {
  "hrsh7th/nvim-cmp",
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

    {
      "hrsh7th/cmp-cmdline",
      event = "CmdlineEnter",
      config = function()
        local cmp = require "cmp"

        cmp.setup.cmdline("/", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = { { name = "buffer" } },
        })

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
          matching = { disallow_symbol_nonprefix_matching = false },
        })
      end,
    },
  },
  opts = function(_, opts)
    for _, source in ipairs(opts.sources) do
      source.group_index = 2
    end

    opts.sources[1].trigger_characters = { "-" }

    table.insert(opts.sources, 1, { name = "render-markdown", group_index = 2 })
    table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })

    opts.formatting = {
      format = require("lspkind").cmp_format {
        mode = "symbol", -- show only symbol annotations
        maxwidth = { menu = 50, abbr = 50 },
        ellipsis_char = "...",
        show_labelDetails = true,
        before = function(entry, vim_item)
          local highlights_info = require("colorful-menu").cmp_highlights(entry)
          if highlights_info then
            vim_item.abbr_hl_group = highlights_info.highlights
            vim_item.abbr = highlights_info.text
          end
          return vim_item
        end,
      },
    }
  end,
}
