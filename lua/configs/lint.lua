local lint = require "lint"

lint.linters_by_ft = {
  lua = { "luacheck" },
  ruby = { "rubocop" },
  typescript = { "eslint_d" },
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  html = { "htmlhint" },
  css = { "stylelint" },
  scss = { "stylelint" },
  sass = { "stylelint" },
  less = { "stylelint" },
  json = { "jsonlint" },
  go = { "golangcilint" },
  rust = { "clippy" },
  markdown = { "markdownlint-cli2" },
  terraform = { "tflint", "tfsec" },
  hcl = { "tflint", "tfsec" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  zsh = { "shellcheck" },
}

local luacheck_args = lint.linters.luacheck.args or {}
vim.list_extend(luacheck_args, { "--globals", "vim" })
lint.linters.luacheck.args = luacheck_args

-- Configure eslint_d to respect project configs
lint.linters.eslint_d = {
  cmd = "eslint_d",
  args = {
    "--format",
    "json",
    "--stdin",
    "--stdin-filename",
    function()
      return vim.api.nvim_buf_get_name(0)
    end,
  },
  stream = "stdout",
  ignore_exitcode = true,
  parser = function(output, bufnr)
    -- Parse eslint JSON output
    local ok, decoded = pcall(vim.json.decode, output)
    if not ok or not decoded[1] then
      return {}
    end

    local diagnostics = {}
    local offenses = decoded[1].messages or {}

    for _, offense in ipairs(offenses) do
      table.insert(diagnostics, {
        bufnr = bufnr,
        lnum = offense.line - 1,
        col = offense.column - 1,
        end_lnum = offense.endLine and offense.endLine - 1 or nil,
        end_col = offense.endColumn and offense.endColumn - 1 or nil,
        severity = offense.severity == 2 and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
        message = offense.message,
        source = "eslint",
        code = offense.ruleId,
      })
    end

    return diagnostics
  end,
}

-- Custom Go linter for nilaway
lint.linters.nilaway = {
  sourceName = "nilaway",
  command = "nilaway",
  rootPatterns = { ".git", "go.mod" },
  debounce = 100,
  args = { "--stdin" },
  parseJson = {
    sourceName = "file",
    errorsRoot = "errors",
    line = "line",
    column = "column",
    endLine = "endLine",
    endColumn = "endColumn",
    message = "${message} [${ruleId}]",
  },
}

-- Auto-lint with debouncing
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
  group = lint_augroup,
  callback = function()
    -- Debounce linting
    vim.defer_fn(function()
      lint.try_lint()
    end, 100)
  end,
})

-- Manual lint command
vim.api.nvim_create_user_command("Lint", function()
  lint.try_lint()
end, { desc = "Run linters manually" })
