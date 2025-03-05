local options = {
  ensure_installed = {
    "bash",
    "css",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "hcl",
    "html",
    "javascript",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "printf",
    "ruby",
    "toml",
    "terraform",
    "typescript",
    "tsx",
    "vim",
    "vimdoc",
    "yaml",
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
  textobjects = require "configs.treesitter-textobjects",
}

require("nvim-treesitter.configs").setup(options)
