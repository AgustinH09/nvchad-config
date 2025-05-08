return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "Lspsaga" },
  keys = {
    { "gh", "<cmd>Lspsaga finder ++normal tyd+ref+imp+def<CR>", desc = "LSP Finder" },
    { "gp", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
    { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev Diagnostic" },
    { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
    { "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Line Diagnostics" },
    { "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "Buffer Diagnostics" },
    { "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
    { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
    { "<leader>t", "<cmd>Lspsaga term_toggle<CR>", desc = "Toggle Terminal" },
    { "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "Code Action" },
  },
  config = function()
    require("lspsaga").setup {
      lightbulb = { enable = false },
      code_action = {
        num_shortcut = true,
        show_server_name = false,
        extend_gitsigns = true,
        keys = {
          quit = "q",
          exec = "<CR>",
        },
      },
    }
  end,
}
