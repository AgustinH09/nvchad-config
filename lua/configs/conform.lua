-- plugins/conform.lua (or wherever your config resides)

local global_formatters = { "trim_whitespace", "trim_newlines" }

local formatters_by_ft = {
  lua = { "stylua" },
  css = { "stylelint" },
  scss = { "stylelint" },
  html = { "prettier" },
  ruby = { "rubocop" }, -- Keep rubocop listed here for the filetype association
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
    -- Add configuration for rubocop
    rubocop = {
      -- Specify 'bundle' as the command
      command = "bundle",
      -- Pass arguments to 'bundle': exec rubocop, flags for formatting, disable server, read from stdin, pass filename
      args = { "exec", "rubocop", "-A", "--no-server", "--stdin", vim.api.nvim_buf_get_name(0) },
      -- Tell conform to send buffer content via stdin
      stdin = true,
      -- Optional: Define environment variables if needed, e.g., to ensure PATH includes mise shims
      -- env = {
      --   PATH = vim.fn.getenv("HOME") .. "/.local/share/mise/shims:" .. vim.fn.getenv("PATH"),
      -- }
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

    -- Timeout is 500ms, might need increasing if RuboCop is still slow even without server mode
    return { timeout_ms = 1500, lsp_format = "fallback" }
  end,

  notify_on_error = true,
  notify_no_formatters = true, -- Set to false if you don't want messages when no formatter is found

  -- Deprecated in newer conform versions, setup happens automatically
  -- init = function()
  --  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  -- end,
}

return options
