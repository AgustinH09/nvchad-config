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

    table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })

    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local completion_item = entry:get_completion_item()
        local highlights_info = require("colorful-menu").highlights(completion_item, vim.bo.filetype)

        -- if colorful-menu cannot find highlights for the filetype,
        -- fallback to the completion_item's original label
        if highlights_info == nil then
          vim_item.abbr = completion_item.label
        else
          vim_item.abbr_hl_group = highlights_info.highlights
          vim_item.abbr = highlights_info.text
        end

        local kind = require("lspkind").cmp_format {
          mode = "symbol_text",
        }(entry, vim_item)

        -- split the returned kind text on spaces
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        -- e.g., if kind.kind was " Class", then strings = {"", "Class"}
        vim_item.kind = " " .. (strings[1] or "") .. " "

        -- remove the menu text for a cleaner look
        vim_item.menu = ""

        return vim_item
      end,
    }
  end,
}

