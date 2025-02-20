local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    ruby = { "rubocop" },
    go = { "gofumpt", "goimports-reviser", "golines", "crlfmt" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    node = { "prettier" },
    markdown = { "cbfmt", "markdownlint-cli2" },
    terraform = { "terraform_fmt" },
  },

  formatters = {
    ["goimports-reviser"] = {
      prepend_args = { "-rm-unused" },
    },
    golines = {
      prepend_args = { "--max-len=80" },
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
