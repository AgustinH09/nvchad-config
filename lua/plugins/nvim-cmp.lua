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
      format = function(entry, vim_item)
        local highlights_info = require("colorful-menu").cmp_highlights(entry)

        -- if highlight_info==nil, which means missing ts parser, let's fallback to use default `vim_item.abbr`.
        -- What this plugin offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
        if highlights_info ~= nil then
          vim_item.abbr_hl_group = highlights_info.highlights
          vim_item.abbr = highlights_info.text
        end

        return vim_item
      end,
    }
  end,
}
