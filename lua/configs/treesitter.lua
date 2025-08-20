local options = {
  ensure_installed = {
    "bash",
    "css",
    "diff",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "hcl",
    "html",
    "hyprlang",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "printf",
    "python",
    "regex",
    "ruby",
    "rust",
    "sql",
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
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
    disable = { "yaml" }, -- YAML indentation can be tricky
  },

  -- Incremental selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-backspace>",
    },
  },

  -- Better folding
  fold = {
    enable = true,
  },

  -- Rainbow parentheses
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },

  -- Context-aware commenting
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  textobjects = require "configs.treesitter-textobjects",
}

require("nvim-treesitter.configs").setup(options)

-- Set up treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Don't fold by default
vim.opt.foldlevel = 99
