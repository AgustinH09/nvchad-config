require "nvchad.mappings"

local map = vim.keymap.set
local delete = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<leader>q", "<cmd>q<cr>", { desc = "quit" })
map("n", "<leader>Q", "<cmd>q!<cr>", { desc = "force quit" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Paste in vs mode
map("x", "<leader>p", [["_dP]])
-- Delete without affecting the Y buffer
map({ "n", "v" }, "<leader>d", [["_d]])
-- Disable Ex mode
map("n", "Q", "<nop>")

-- Remove the default mappings
delete("n", "S")
delete("n", "<A-h>")
delete("n", "<A-v>")
delete("n", "<C-s>")
delete("n", "<leader>n")

-- MiniMove
-- Move left
map("n", "<M-h>", "<cmd>lua require('mini.move').move_line('left')<CR>", { desc = "Move line left" })
map("v", "<M-h>", "<cmd>lua require('mini.move').move_selection('left')<CR>", { desc = "Move selection left" })

-- Move right
map("n", "<M-l>", "<cmd>lua require('mini.move').move_line('right')<CR>", { desc = "Move line right" })
map("v", "<M-l>", "<cmd>lua require('mini.move').move_selection('right')<CR>", { desc = "Move selection right" })

-- Move up
map("n", "<M-k>", "<cmd>lua require('mini.move').move_line('up')<CR>", { desc = "Move line up" })
map("v", "<M-k>", "<cmd>lua require('mini.move').move_selection('up')<CR>", { desc = "Move selection up" })

-- Move down
map("n", "<M-j>", "<cmd>lua require('mini.move').move_line('down')<CR>", { desc = "Move line down" })
map("v", "<M-j>", "<cmd>lua require('mini.move').move_selection('down')<CR>", { desc = "Move selection down" })

-- Terminals
map("n", "<leader>th", "<cmd>split | terminal<CR>", { desc = "Horizontal Terminal", noremap = true, silent = true })
map("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Vertical Terminal", noremap = true, silent = true })

----- Undotree
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undotree" })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf, noremap = true, silent = true }

    -- Go to definition
    map("n", "gd", vim.lsp.buf.definition, opts)
    -- Go to declaration
    map("n", "gD", vim.lsp.buf.declaration, opts)
    -- Go to implementation
    map("n", "gi", vim.lsp.buf.implementation, opts)
    -- Go to type definition
    map("n", "gt", vim.lsp.buf.type_definition, opts)
    -- Show hover information
    -- map("n", "K", vim.lsp.buf.hover, opts)
    -- Show signature help
    -- map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- List references
    map("n", "gr", vim.lsp.buf.references, opts)
    -- Rename symbol
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    -- Code action
    -- map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>f", function()
      require("conform").format { lsp_fallback = true }
    end, opts)
    -- Diagnostics
    map("n", "gl", vim.diagnostic.open_float, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

----- OBSIDIAN -----
map("n", "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>", { desc = "Obsidian Check Checkbox" })
map("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
map("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
map("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
map("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
map("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
map("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
map("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })

----- GoDoc ----
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<leader>gd",
      ":GoDoc<CR>",
      { desc = "Open GoDocs in Telescope", noremap = true, silent = true }
    )
  end,
})

------ Celluar Automaton ----
map("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

------ Tmux -----
-- Navigation (moving between nvim splits and tmux panes)
map("n", "<C-h>", "<cmd>lua require('tmux').move_left()<cr>", { desc = "Move to left tmux pane" })
map("n", "<C-j>", "<cmd>lua require('tmux').move_bottom()<cr>", { desc = "Move to bottom tmux pane" })
map("n", "<C-k>", "<cmd>lua require('tmux').move_top()<cr>", { desc = "Move to top tmux pane" })
map("n", "<C-l>", "<cmd>lua require('tmux').move_right()<cr>", { desc = "Move to right tmux pane" })

-- Resize (adjusting tmux pane sizes) with Alt + Arrow keys
map("n", "<M-Left>", "<cmd>lua require('tmux').resize_left()<cr>", { desc = "Resize left tmux pane" })
map("n", "<M-Down>", "<cmd>lua require('tmux').resize_bottom()<cr>", { desc = "Resize bottom tmux pane" })
map("n", "<M-Up>", "<cmd>lua require('tmux').resize_top()<cr>", { desc = "Resize top tmux pane" })
map("n", "<M-Right>", "<cmd>lua require('tmux').resize_right()<cr>", { desc = "Resize right tmux pane" })

-- Swap (swapping positions with adjacent tmux panes)
map("n", "<C-M-h>", "<cmd>lua require('tmux').swap_left()<cr>", { desc = "Swap with left tmux pane" })
map("n", "<C-M-j>", "<cmd>lua require('tmux').swap_bottom()<cr>", { desc = "Swap with bottom tmux pane" })
map("n", "<C-M-k>", "<cmd>lua require('tmux').swap_top()<cr>", { desc = "Swap with top tmux pane" })
map("n", "<C-M-l>", "<cmd>lua require('tmux').swap_right()<cr>", { desc = "Swap with right tmux pane" })

----- Zen Mode -----
map("n", "<leader>zm", "<cmd>ZenMode<CR>", { desc = "Zen Mode" })

----- Quickfix -----
map("n", "<C-q>", function()
  require("quicker").toggle()
end, {
  desc = "Toggle quickfix",
})

map("n", "<leader>l", function()
  require("quicker").toggle { loclist = true }
end, { desc = "Toggle loclist" })

---- NvimTree -----
map({ "n", "v", "x" }, "<leader>fc", function()
  require("nvim-tree.api").tree.find_file { open = true, focus = false }
end, { desc = "Current File in NvimTree" })

---- Projects -----
map("n", "<leader>fp", function()
  require("telescope").extensions.projects.projects {}
end, { desc = "Open Telescope Projects Picker" })
