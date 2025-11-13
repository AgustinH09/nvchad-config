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

----- BASIC NAVIGATION & EDITING -----
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

M("n", "<leader>gv", "`[v`]", { desc = "Visually select last paste/change" })

-- disable Ex mode
M("n", "Q", "<nop>", { desc = "Disable Ex mode" })

----- FILE OPERATIONS -----
M("n", "<C-c>", require "functions.file_context", { desc = "Copy file with context for LLM" })

-- Copy file & line paths to clipboard
-- M("n", "<leader>fL", function()
--   local file = vim.fn.expand "%"
--   local line = vim.fn.line "."
--   vim.fn.setreg("+", string.format("%s:%d", file, line))
--   vim.notify "Copied line reference to clipboard"
-- end, { desc = "Copy line reference to clipboard" })

-- Delete NvChad default mappings
del("n", "<leader>ch")
del("n", "<leader>th")
del("n", "<leader>fm")

----- BUFFER MANAGEMENT -----
M("n", "<leader>x", "<cmd>bd<cr>", { desc = "Close buffer" })
M("n", "<leader>X", "<cmd>bd!<cr>", { desc = "Force close buffer" })
-- M("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- M("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

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

----- LSP (Language Server Protocol) -----
local lsp_grp = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_grp,
  callback = function(ev)
    local bufn = ev.buf
    local opts = vim.tbl_extend("force", default_opts, { buffer = bufn })

    -- Go to definitions
    M("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    M("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    M("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    M("n", "<leader>lT", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
    M("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "List references" }))

    -- Refactoring
    M("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    -- Native LSP code actions (commented out in favor of LSPsaga)
    -- M("n", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
    -- M("v", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))

    -- Formatting (Also available as <leader>Ff)
    M("n", "<leader>lf", function()
      require("conform").format { lsp_fallback = true }
    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))

    -- Diagnostics (commented out in favor of LSPsaga)
    -- M("n", "gl", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
    -- M("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    -- M("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

    -- Native diagnostics - keeping as alternatives with different keys
    M(
      "n",
      "<leader>ll",
      vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "Show diagnostics (native)" })
    )
    M("n", "[D", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic (native)" }))
    M("n", "]D", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic (native)" }))

    -- Hover (commented out in favor of LSPsaga K mapping)
    -- M("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))

    -- LSP management
    M("n", "<leader>lh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufn }, { bufnr = bufn })
    end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))

    M("n", "<leader>ld", function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled { bufnr = bufn }, { bufnr = bufn })
    end, vim.tbl_extend("force", opts, { desc = "Toggle diagnostics" }))

    M("n", "<leader>lH", function()
      -- Toggle harper_ls (grammar/spelling checker)
      local clients = vim.lsp.get_clients { bufnr = bufn, name = "harper_ls" }
      if #clients > 0 then
        vim.lsp.stop_client(clients[1].id)
        vim.notify("Harper LSP stopped", vim.log.levels.INFO)
      else
        -- Try to restart harper_ls if it was stopped
        vim.cmd "LspStart harper_ls"
        vim.notify("Harper LSP started", vim.log.levels.INFO)
      end
    end, vim.tbl_extend("force", opts, { desc = "Toggle Harper LSP (grammar)" }))

    M("n", "<leader>li", "<cmd>LspInfo<cr>", vim.tbl_extend("force", opts, { desc = "LSP info" }))
    M("n", "<leader>lR", "<cmd>LspRestart<cr>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
  end,
})

----- OBSIDIAN -----
M("n", "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>", { desc = "Toggle checkbox" })
M("n", "<leader>ot", "<cmd>Obsidian template<CR>", { desc = "Insert template" })
M("n", "<leader>oo", "<cmd>Obsidian open<CR>", { desc = "Open in app" })
M("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Show backlinks" })
M("n", "<leader>ol", "<cmd>Obsidian links<CR>", { desc = "Show links" })
M("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "New note" })
M("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Search notes" })
M("n", "<leader>oq", "<cmd>Obsidian quick_switch<CR>", { desc = "Quick switch" })

----- GIT -----
M("n", "<leader>gb", function()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle git blame" })

M("n", "<leader>gB", function()
  require("gitsigns").blame_line { full = true }
end, { desc = "Full git blame" })

M("n", "<leader>gd", function()
  require("gitsigns").diffthis()
end, { desc = "Git diff" })

M("n", "<leader>gD", function()
  require("gitsigns").diffthis "~"
end, { desc = "Git diff against last commit" })

M("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })

M("n", "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })

M("n", "<leader>gR", function()
  require("gitsigns").reset_buffer()
end, { desc = "Reset buffer" })

M("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })

M("n", "<leader>gS", function()
  require("gitsigns").stage_buffer()
end, { desc = "Stage buffer" })

M("n", "<leader>gu", function()
  require("gitsigns").undo_stage_hunk()
end, { desc = "Undo stage hunk" })

-- Navigation
M("n", "]g", function()
  require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })

M("n", "[g", function()
  require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })

----- LANGUAGE SPECIFIC -----
-- Rust (rustaceanvim)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    -- Code actions & diagnostics
    M("n", "<leader>ra", function()
      vim.cmd.RustLsp "codeAction"
    end, { desc = "Code actions" })
    M("v", "<leader>ra", function()
      vim.cmd.RustLsp "codeAction"
    end, { desc = "Code actions" })
    M("n", "K", function()
      vim.cmd.RustLsp { "hover", "actions" }
    end, { desc = "Hover actions" })
    M("n", "<leader>re", function()
      vim.cmd.RustLsp "explainError"
    end, { desc = "Explain error" })
    M("n", "<leader>rd", function()
      vim.cmd.RustLsp "renderDiagnostic"
    end, { desc = "Render diagnostic" })

    -- Running & debugging
    M("n", "<leader>rr", function()
      vim.cmd.RustLsp "runnables"
    end, { desc = "Runnables" })
    M("n", "<leader>rD", function()
      vim.cmd.RustLsp "debuggables"
    end, { desc = "Debuggables" })
    M("n", "<leader>rt", function()
      vim.cmd.RustLsp "testables"
    end, { desc = "Testables" })

    -- Code exploration
    M("n", "<leader>rE", function()
      vim.cmd.RustLsp "expandMacro"
    end, { desc = "Expand macro" })
    M("n", "<leader>rc", function()
      vim.cmd.RustLsp "openCargo"
    end, { desc = "Open Cargo.toml" })
    M("n", "<leader>rp", function()
      vim.cmd.RustLsp "parentModule"
    end, { desc = "Parent module" })

    -- Refactoring
    M("n", "<leader>rmu", function()
      vim.cmd.RustLsp("moveItem", "up")
    end, { desc = "Move item up" })
    M("n", "<leader>rmd", function()
      vim.cmd.RustLsp("moveItem", "down")
    end, { desc = "Move item down" })
    M("n", "J", function()
      vim.cmd.RustLsp "joinLines"
    end, { desc = "Join lines" })
    M("n", "<leader>rs", function()
      vim.cmd.RustLsp "ssr"
    end, { desc = "Structural search replace" })

    -- View modes
    M("n", "<leader>rst", function()
      vim.cmd.RustLsp { "syntaxTree" }
    end, { desc = "View syntax tree" })
    M("n", "<leader>rh", function()
      vim.cmd.RustLsp { "view", "hir" }
    end, { desc = "View HIR" })
    M("n", "<leader>rm", function()
      vim.cmd.RustLsp { "view", "mir" }
    end, { desc = "View MIR" })

    -- Cargo commands
    M("n", "<leader>Cb", "<cmd>Cargo build<cr>", { desc = "Cargo build" })
    M("n", "<leader>Cr", "<cmd>Cargo run<cr>", { desc = "Cargo run" })
    M("n", "<leader>Ct", "<cmd>Cargo test<cr>", { desc = "Cargo test" })
    M("n", "<leader>Cc", "<cmd>Cargo check<cr>", { desc = "Cargo check" })
    M("n", "<leader>Cl", "<cmd>Cargo clippy<cr>", { desc = "Cargo clippy" })
    M("n", "<leader>Cf", "<cmd>Cargo fmt<cr>", { desc = "Cargo fmt" })
    M("n", "<leader>Cd", "<cmd>RustDoc<cr>", { desc = "Search Rust docs" })
    M("n", "<leader>Cp", "<cmd>RustPlayground<cr>", { desc = "Open in Playground" })
    M("n", "<leader>Ca", ":CargoAddDep ", { desc = "Add dependency" })
    M("n", "<leader>Cs", ":CrateSearch ", { desc = "Search crates.io" })
  end,
})

-- Markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    M("n", "<leader>mp", "<cmd>MarkdownPerformanceMode<cr>", { desc = "Enable Markdown performance mode" })
    M("n", "<leader>mn", "<cmd>MarkdownNormalMode<cr>", { desc = "Enable Markdown normal mode" })
    -- M("n", "<leader>mP", "<cmd>MarkdownPreview<cr>", { desc = "Preview Markdown" })
  end,
})

-- Go
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    M("n", "<leader>gd", "<cmd>GoDoc<CR>", { desc = "GoDoc in Telescope" })
    M("n", "<leader>goA", "<cmd>GoAlternate<CR>", { desc = "Go alternate file (test <-> impl)" })
  end,
})

----- FUN & UI -----
-- Cellular Automaton
M("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })

-- Zen Mode
M("n", "<leader>zm", "<cmd>ZenMode<CR>", { desc = "Zen Mode" })

-- Code Folding
M("n", "zR", "<cmd>set foldlevel=99<CR>", { desc = "Open all folds" })
M("n", "zM", "<cmd>set foldlevel=0<CR>", { desc = "Close all folds" })
M("n", "za", "za", { desc = "Toggle fold under cursor" })
M("n", "zA", "zA", { desc = "Toggle all folds under cursor" })
M("n", "zr", "<cmd>set foldlevel+=1<CR>", { desc = "Increase fold level" })
M("n", "zm", "<cmd>set foldlevel-=1<CR>", { desc = "Decrease fold level" })

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

----- QUICKFIX & LOCATION LIST -----
M("n", "<C-q>", function()
  require("quicker").toggle()
end, { desc = "Toggle quickfix" })
-- M("n", "<leader>ql", function()
--   require("quicker").toggle { loclist = true }
-- end, { desc = "Toggle loclist" })

-- Navigation for items
M("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
M("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })
M("n", "<M-n>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
M("n", "<M-p>", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

-- Navigation for lists (history)
M("n", "<leader>]q", "<cmd>cnewer<CR>", { desc = "Newer quickfix list" })
M("n", "<leader>[q", "<cmd>colder<CR>", { desc = "Older quickfix list" })

----- LINTING & DIAGNOSTICS -----
M("n", "<leader>ly", function()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local diagnostics = vim.diagnostic.get(0, { lnum = row - 1 })

  if vim.tbl_isempty(diagnostics) then
    vim.notify("No diagnostic on current line", vim.log.levels.WARN)
    return
  end

  local diagnostic = diagnostics[1]
  local message = diagnostic.message
  local line_num = diagnostic.lnum + 1
  local line_content = vim.fn.getline(line_num)

  local output = string.format("Line %d: %s\n---\n%s", line_num, vim.trim(line_content), message)

  vim.fn.setreg("+", output)
  vim.notify("Copied diagnostic with context!", vim.log.levels.INFO)
end, { desc = "Copy diagnostic w/ context" })

M("n", "<leader>Ll", "<cmd>Lint<cr>", { desc = "Run linters" })

M("n", "<leader>LL", function()
  -- Show all diagnostics in quickfix
  vim.diagnostic.setqflist()
  vim.cmd "copen"
end, { desc = "Diagnostics to quickfix" })

M("n", "<leader>Lb", function()
  -- Show buffer diagnostics in loclist
  vim.diagnostic.setloclist()
end, { desc = "Buffer diagnostics to loclist" })

M("n", "<leader>Le", function()
  -- Show only errors
  vim.diagnostic.setqflist { severity = vim.diagnostic.severity.ERROR }
  vim.cmd "copen"
end, { desc = "Errors to quickfix" })

M("n", "<leader>Lw", function()
  -- Show only warnings
  vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
  vim.cmd "copen"
end, { desc = "Warnings to quickfix" })

----- FILE NAVIGATION -----
-- NvimTree
M({ "n", "v", "x" }, "<leader>fc", function()
  require("nvim-tree.api").tree.find_file { open = true, focus = false }
end, { desc = "Find file in tree" })

-- Projects (Telescope)
M("n", "<leader>fp", function()
  require("telescope").extensions.projects.projects {}
end, { desc = "Telescope Projects" })

----- SNIPPETS (LuaSnip) -----
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
