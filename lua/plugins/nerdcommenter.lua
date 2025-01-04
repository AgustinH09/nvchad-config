return {
  "preservim/nerdcommenter",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("configs.nerdcommenter").setup()
  end,
}
