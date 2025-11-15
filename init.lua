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
require "cmds"

vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  once = true,
  callback = function()
    require "configs.go"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby", "eruby" },
  once = true,
  callback = function()
    require "configs.ruby"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  once = true,
  callback = function()
    require "configs.rust"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  once = true,
  callback = function()
    require "configs.markdown"
  end,
})

-- Enable persistent undo with better location
vim.defer_fn(function()
  local undo_dir = vim.fn.stdpath "data" .. "/undo"
  if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p", tonumber("700", 8))
  end

  vim.opt.undodir = undo_dir
  vim.opt.undofile = true
end, 50)
