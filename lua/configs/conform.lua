local global_formatters = { "trim_whitespace", "trim_newlines" }

local formatters_by_ft = {
  lua = { "stylua" },
  css = { "prettier" },
  html = { "prettier" },
  ruby = { "rubocop" },
  go = { "gofumpt", "goimports-reviser", "golines", "crlfmt" },
  -- javascript = { "prettierd" },
  -- typescript = { "prettierd" },
  -- node = { "prettierd" },
  markdown = { "cbfmt", "markdownlint-cli2" },
  terraform = { "terraform_fmt" },
}

for ft, fmt in pairs(formatters_by_ft) do
  formatters_by_ft[ft] = vim.list_extend(vim.deepcopy(fmt), global_formatters)
end

local options = {
  formatters_by_ft = formatters_by_ft,

  formatters = {
    ["goimports-reviser"] = {
      prepend_args = { "-rm-unused" },
    },
    golines = {
      prepend_args = { "--max-len=80" },
    },
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable in /node_modules/
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match "/node_modules/" then
      return
    end

    return { timeout_ms = 500, lsp_format = "fallback" }
  end,

  notify_on_error = true,
  notify_no_formatters = true,

  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

return options
