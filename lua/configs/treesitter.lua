local options = {
  ensure_installed = {
    "bash",
    "fish",
    "lua",
    "luadoc",
    "markdown",
    "printf",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
    "ruby",
    "go",
    "gomod",
    "gosun",
    "gotmpl",
    "gowork",
    "css",
    "javascript",
    "typescript",
    "node",
    "help",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
