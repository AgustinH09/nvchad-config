return {
  "echasnovski/mini.nvim",
  version = "*",
  event = "BufEnter",
  config = function()
    require("configs.mini.ai").setup()
    -- require("configs.mini.animate").setup()
    -- require("configs.mini.bracketed").setup()
    require("configs.mini.move").setup()
    require("configs.mini.trailspace").setup()
  end,
}
