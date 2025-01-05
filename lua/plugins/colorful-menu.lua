return {
  "xzbdmw/colorful-menu.nvim",
  config = function()
    require("colorful-menu").setup {
      ft = {
        lua = {
          auguments_hl = "@comment",
        },
        go = {
          add_colon_before_type = false,
        },
        typescript = {
          enabled = { "typescript", "typescriptreact", "typescript.tsx" },
          ls = "typescript-language-server",
          extra_info_hl = "@comment",
        },
        rust = {
          extra_info_hl = "@comment",
        },
        c = {
          extra_info_hl = "@comment",
        },
        -- If true, try to highlight "not supported" languages.
        fallback = true,
      },
      fallback_highlight = "@variable",
      max_width = 60,
    }
  end,
}

