local lspconfig = require "lspconfig"

-- which of your lspconfig servers to skip installing
local ignore_install = { "markdown-oxide" }

-- NOTE: Corrected "ts_ls" to "tsserver" in this list
local to_install = vim.tbl_filter(function(name)
  return not vim.tbl_contains(ignore_install, name)
end, {
  "biome",
  "cssls",
  "eslint",
  "gopls",
  "harper_ls",
  "html",
  "hyprls",
  "jsonls",
  "lua_ls",
  "markdown-oxide",
  "marksman",
  "ruby_lsp",
  "ts_ls",
})

require("mason-lspconfig").setup {
  ensure_installed = to_install,
  automatic_enable = false,
}
