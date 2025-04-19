return {
  "zeioth/garbage-day.nvim",
  dependencies = "neovim/nvim-lspconfig",
  event = "VeryLazy",
  opts = {
    notifications = true,
    excluded_lsp_clients = { "copilot" },
  },
}
