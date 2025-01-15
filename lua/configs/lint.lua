local lint = require "lint"

lint.linters_by_ft = {
  lua = { "luacheck" },
  ruby = { "rubocop" },
  typescript = { "eslint_d" },
  javascript = { "eslint_d" },
  node = { "eslint_d" },
  html = { "htmlhint" },
  css = { "stylelint" },
  scss = { "stylelint" },
  sass = { "stylelint" },
  less = { "stylelint" },
  json = { "jsonlint" },
  go = { "golangcilint" },
  markdwon = { "markdownlint-cli2" },
}

lint.linters.luacheck.args = {
  table.unpack(lint.linters.luacheck.args),
  "--globals",
  "vim",
}

lint.linters.nilaway = {
  sourceName = "nilaway",
  command = "nilaway",
  rootPatterns = { ".git" },
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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
