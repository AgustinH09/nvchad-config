-- plugins/conform.lua (or wherever your config resides)

local global_formatters = { "trim_whitespace", "trim_newlines" }

local formatters_by_ft = {
  lua = { "stylua" },
  css = { "stylelint" },
  scss = { "stylelint" },
  html = { "prettier" },
  ruby = { "rubocop" },
  go = { "gofumpt", "goimports-reviser", "golines", "crlfmt" },
  -- javascript = { "prettierd" },
  -- typescript = { "prettierd" },
  -- node = { "prettierd" },
  markdown = { "cbfmt", "markdownlint-cli2" },
  terraform = { "terraform_fmt" },
}

-- Add global formatters to each filetype list
for ft, fmt in pairs(formatters_by_ft) do
  formatters_by_ft[ft] = vim.list_extend(vim.deepcopy(fmt), global_formatters)
end

local options = {
  formatters_by_ft = formatters_by_ft,

  -- Define specific formatter configurations here
  formatters = {
    ["goimports-reviser"] = {
      prepend_args = { "-rm-unused" },
    },
    golines = {
      prepend_args = { "--max-len=80" },
    },
    rubocop = {
      -- https://github.com/stevearc/conform.nvim/issues/369
      args = { "--server", "--auto-correct-all", "--stderr", "--force-exclusion", "--stdin", "$FILENAME" },
    },
  },

  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match "/node_modules/" then
      return
    end
    return { timeout_ms = 600, lsp_format = "fallback" }
  end,

  notify_on_error = true,
  notify_no_formatters = true,
}

return options
