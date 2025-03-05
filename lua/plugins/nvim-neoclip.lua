return {
  "AckslD/nvim-neoclip.lua",
  enabled = false,
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    require("neoclip").setup {
      history = 500,
      enable_persistent_history = true,
      continous_sync = false,
      db_path = "/databases/neoclip.sqlite3",
      preview = true,
    }
  end,
}
