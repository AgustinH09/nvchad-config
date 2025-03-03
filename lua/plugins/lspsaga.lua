return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  ft = { "c", "cpp", "lua", "rust", "go" },
  config = function()
    require("lspsaga").setup {
      lightbulb = {
        enable = false,
      },
    }
    local opts = { noremap = true, silent = true }

    -- Enhanced LSP Finder & Peek Definition
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp", "lua", "rust", "go" },
      callback = function()
        vim.keymap.set("n", "gh", "<cmd>Lspsaga finder ++normal tyd+ref+imp+def<CR>", opts)
        vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
      end,
    })

    -- Show Outline (Symbol tree, useful for navigation)
    vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)

    -- Diagnostic Jump with Severity Filtering
    vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

    -- Show Line Diagnostics (Improved floating diagnostics)
    vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

    -- Show Buffer Diagnostics
    vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)

    -- Show Workspace Diagnostics
    vim.keymap.set("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)

    -- Floating Hover Doc (Scrollable)
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

    -- Floating Termina
    vim.keymap.set("n", "<leader>t", "<cmd>Lspsaga term_toggle<CR>", opts)
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
    "neovim/nvim-lspconfig",
  },
}
