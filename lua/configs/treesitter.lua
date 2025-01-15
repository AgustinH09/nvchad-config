local options = {
  ensure_installed = {
    "bash",
    "css",
    "fish",
    "go",
    "gomod",
    "gosun",
    "gotmpl",
    "gowork",
    "help",
    "html",
    "javascript",
    "latex",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "node",
    "printf",
    "ruby",
    "toml",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
