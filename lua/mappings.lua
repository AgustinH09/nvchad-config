require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<leader>q", "<cmd>q<cr>", { desc = "quit" })
map("n", "<leader>Q", "<cmd>q!<cr>", { desc = "force quit" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- Undotree
-- ["<leader>j"] = { "<cmd>UndotreeToggle<CR>", "Toggle Undotree"
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undotree" })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf, noremap = true, silent = true }

    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- Go to declaration
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    -- Go to implementation
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- Go to type definition
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    -- Show hover information
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- Show signature help
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- List references
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    -- Rename symbol
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    -- Code action
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    -- Format document
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
    -- Diagnostics
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})
