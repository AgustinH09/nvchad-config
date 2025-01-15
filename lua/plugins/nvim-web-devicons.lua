return {
  "nvim-tree/nvim-web-devicons",
  opts = {},
  config = function()
    require("nvim-web-devicons").setup {
      override = {
        copilot = {
          icon = "",
          color = "#FFA500",
          name = "Copilot",
        },
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh",
        },
      },
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore",
        },
      },
      override_by_extension = {
        ["log"] = {
          icon = "",
          color = "#81e043",
          name = "Log",
        },
      },
    }
  end,
}
