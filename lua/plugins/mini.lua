return {
  "echasnovski/mini.nvim",
  event = "BufWritePre",
  config = function()
    require("configs.mini.trailspace").setup()
  end,
}
