return {
  "RRethy/vim-illuminate",
  version = "*",
  event = "VeryLazy",
  -- enabled = false,
  -- TODO: Eliminate this when upgrade to nvim 0.11
  config = function()
    require("illuminate").configure {
      providers = {
        "regex",
      },
    }
  end,
}
