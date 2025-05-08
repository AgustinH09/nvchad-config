require "nvchad.mappings"

-- helpers
local map = vim.keymap.set
local del = vim.keymap.del
local default_opts = { noremap = true, silent = true }
local function M(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", default_opts, opts or {})
  map(mode, lhs, rhs, opts)
end

-- pull in modules once
local mini_move = require "mini.move"

----- BASIC -----
M("n", ";", ":", { desc = "Enter command mode" })
M("n", "<C-d>", "<C-d>zz", { desc = "Scroll down & center" })
M("n", "<C-u>", "<C-u>zz", { desc = "Scroll up & center" })
M("n", "n", "nzzzv", { desc = "Next search & center" })
M("n", "N", "Nzzzv", { desc = "Prev search & center" })
M("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
M("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Force quit" })

-- paste in visual without overwriting register
M("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
-- delete without yanking
M({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- disable Ex mode
M("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- Delete NvChad default mappings
del("n", "<leader>ch")

----- MINIMOVE -----
M("n", "<M-h>", function()
  mini_move.move_line "left"
end, { desc = "Move line left" })
M("v", "<M-h>", function()
  mini_move.move_selection "left"
end, { desc = "Move selection left" })
M("n", "<M-l>", function()
  mini_move.move_line "right"
end, { desc = "Move line right" })
M("v", "<M-l>", function()
  mini_move.move_selection "right"
end, { desc = "Move selection right" })
M("n", "<M-k>", function()
  mini_move.move_line "up"
end, { desc = "Move line up" })
M("v", "<M-k>", function()
  mini_move.move_selection "up"
end, { desc = "Move selection up" })
M("n", "<M-j>", function()
  mini_move.move_line "down"
end, { desc = "Move line down" })
M("v", "<M-j>", function()
  mini_move.move_selection "down"
end, { desc = "Move selection down" })

----- TERMINALS -----
M("n", "<leader>th", "<cmd>split | terminal<CR>", { desc = "Horizontal Terminal" })
M("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Vertical Terminal" })

----- UNDOTREE -----
M("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

----- LSP -----
local lsp_grp = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_grp,
  callback = function(ev)
    local bufn = ev.buf
    local opts = vim.tbl_extend("force", default_opts, { buffer = bufn })

    M("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    M("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    M("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    M("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
    M("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "List references" }))
    M("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    M("n", "<leader>f", function()
      require("conform").format { lsp_fallback = true }
    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
    M("n", "gl", vim.diagnostic.open_float, opts)
    M("n", "[d", vim.diagnostic.goto_prev, opts)
    M("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

----- OBSIDIAN -----
M("n", "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>", { desc = "Toggle checkbox" })
M("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert template" })
M("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in app" })
M("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show backlinks" })
M("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show links" })
M("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New note" })
M("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search notes" })
M("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick switch" })

----- GoDoc -----
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    M("n", "<leader>gd", "<cmd>GoDoc<CR>", { desc = "GoDoc in Telescope" })
  end,
})

----- CELLULAR AUTOMATON -----
M("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })

----- TMUX NAVIGATOR (only if inside tmux) -----
if vim.env.TMUX and vim.env.TMUX ~= "" then
  local ok, lazy = pcall(require, "lazy")
  if ok then
    lazy.load { plugins = "tmux.nvim" }
  end

  M("n", "<C-h>", "<cmd>lua require('tmux').move_left()<CR>", { desc = "← pane" })
  M("n", "<C-j>", "<cmd>lua require('tmux').move_bottom()<CR>", { desc = "↓ pane" })
  M("n", "<C-k>", "<cmd>lua require('tmux').move_top()<CR>", { desc = "↑ pane" })
  M("n", "<C-l>", "<cmd>lua require('tmux').move_right()<CR>", { desc = "→ pane" })

  M("n", "<C-Up>", "<cmd>lua require('tmux').resize_top()<CR>", { desc = "Resize ↑ pane" })
  M("n", "<C-Down>", "<cmd>lua require('tmux').resize_bottom()<CR>", { desc = "Resize ↓ pane" })
  M("n", "<C-Left>", "<cmd>lua require('tmux').resize_left()<CR>", { desc = "Resize ← pane" })
  M("n", "<C-Right>", "<cmd>lua require('tmux').resize_right()<CR>", { desc = "Resize → pane" })

  M("n", "<A-Up>", "<cmd>lua require('tmux').swap_top()<CR>", { desc = "Swap ↑ pane" })
  M("n", "<A-Down>", "<cmd>lua require('tmux').swap_bottom()<CR>", { desc = "Swap ↓ pane" })
  M("n", "<A-Left>", "<cmd>lua require('tmux').swap_left()<CR>", { desc = "Swap ← pane" })
  M("n", "<A-Right>", "<cmd>lua require('tmux').swap_right()<CR>", { desc = "Swap → pane" })
end

----- ZEN MODE -----
M("n", "<leader>zm", "<cmd>ZenMode<CR>", { desc = "Zen Mode" })

----- QUICKFIX -----
M("n", "<C-q>", function()
  require("quicker").toggle()
end, { desc = "Toggle quickfix" })
M("n", "<leader>l", function()
  require("quicker").toggle { loclist = true }
end, { desc = "Toggle loclist" })

----- NVIMTREE -----
M({ "n", "v", "x" }, "<leader>fc", function()
  require("nvim-tree.api").tree.find_file { open = true, focus = false }
end, { desc = "Find file in tree" })

----- PROJECTS (Telescope) -----
M("n", "<leader>fp", function()
  require("telescope").extensions.projects.projects {}
end, { desc = "Telescope Projects" })

----- LUA SNIPPETS -----
local ls = require "luasnip"
local extras = require "luasnip.extras"
local feedkeys = vim.api.nvim_feedkeys
local rep_tc = vim.api.nvim_replace_termcodes

-- Expand or jump forward; otherwise insert a real Tab
M({ "i", "s" }, "<Tab>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
    feedkeys(rep_tc("<Plug>(Tabout)", true, false, true), "n", true)
  end
end, { desc = "LuaSnip expand or jump" })

-- Jump backwards; otherwise insert a real Shift-Tab
M({ "i", "s" }, "<S-Tab>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  else
    feedkeys(rep_tc("<Plug>(TaboutBack)", true, false, true), "n", true)
  end
end, { desc = "LuaSnip jump backward" })

-- Cycle through choice nodes, or fall back to normal <C-j> when not in a choice
M("i", "<C-j>", function()
  if ls.choice_active() then
    extras.change_choice(1)
  else
    feedkeys(rep_tc("<C-j>", true, false, true), "n", true)
  end
end, { desc = "LuaSnip next choice" })
