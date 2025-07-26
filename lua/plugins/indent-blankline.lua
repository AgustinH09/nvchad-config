return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      highlight = { "Function", "Label" },
      include = {
        node_type = {
          lua = { "return_statement", "table_constructor" },
          python = { "return_statement", "dictionary", "list", "tuple" },
          javascript = { "return_statement", "object", "array" },
          typescript = { "return_statement", "object", "array" },
        },
      },
    },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
        "markdown",
      },
      buftypes = { "terminal", "nofile" },
    },
  },
}
