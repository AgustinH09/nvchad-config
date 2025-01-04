local lint = require "lint"

lint.linters_by_ft = {
  lua = { "luacheck" },
  ruby = { "rubocop" },
}

lint.linters.luacheck.args = {
  table.unpack(lint.linters.luacheck.args),
  "--globals",
  "vim",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
