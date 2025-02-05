return {
  "nvim-telescope/telescope-frecency.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "kkharji/sqlite.lua",
  },
  cond = "false",
  cmd = "Telescope",
  version = "*",
  config = function()
    require("telescope").load_extension "frecency"
  end,
}
