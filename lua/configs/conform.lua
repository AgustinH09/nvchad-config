-- plugins/conform.lua (or wherever your config resides)

local global_formatters = { "trim_whitespace", "trim_newlines" }

local formatters_by_ft = {
  lua = { "stylua" },
  css = { "prettier", "stylelint" },
  scss = { "prettier", "stylelint" },
  html = { "prettier" },
  ruby = { "rubocop" },
  go = { "gofumpt", "goimports-reviser", "golines" },
  rust = { "rustfmt" },
  javascript = { "prettier", "eslint_d" },
  typescript = { "prettier", "eslint_d" },
  javascriptreact = { "prettier", "eslint_d" },
  typescriptreact = { "prettier", "eslint_d" },
  json = { "prettier" },
  jsonc = { "prettier" },
  yaml = { "prettier" },
  markdown = { "prettier", "markdownlint-cli2" },
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
    prettier = {
      prepend_args = { "--single-quote", "--trailing-comma", "es5" },
    },
    eslint_d = {
      timeout_ms = 5000,
      condition = function(ctx)
        return vim.fs.find({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" }, { path = ctx.filename, upward = true })[1]
      end,
    },
  },

  format_on_save = function(bufnr)
    -- Disable for specific filetypes
    local ignore_filetypes = { "sql", "java" }
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end

    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match "/node_modules/" or bufname:match "/vendor/" then
      return
    end

    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,

  format_after_save = false,
  notify_on_error = true,
  notify_no_formatters = true,
}

return options
