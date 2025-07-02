return {
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
  -- INFO: Disabled due to incompatibility with neovim 0.11.2
  enabled = false,
  opts = {
    notifications = true,
    excluded_lsp_clients = { "copilot" },
  },
}
