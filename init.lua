vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
  require "configs.harpoon.mappings"
  require "configs.nvim-tree"
end)

-- Enable persistent undo
if vim.fn.has "persistent_undo" == 1 then
  local undodir = vim.fn.expand "~/.undodir"

  -- Create directory if it doesn't exist
  if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p", "0700")
  end

  vim.opt.undodir = undodir
  vim.opt.undofile = true
end
