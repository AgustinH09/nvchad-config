return {
  "lewis6991/gitsigns.nvim",
  event = "BufRead",
  version = "*",
  config = function()
    require("gitsigns").setup()
  end,
}
