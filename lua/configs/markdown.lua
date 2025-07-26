-- Markdown-specific configuration for better performance

local M = {}

-- File size threshold (in KB) for disabling heavy features
local LARGE_FILE_SIZE = 100 -- 100KB threshold for performance mode

M.setup = function()
  -- Detect large markdown files and disable expensive features
  vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = { "*.md", "*.markdown" },
    callback = function(args)
      local bufnr = args.buf
      local filename = args.file

      -- Get file size in KB
      local ok, stats = pcall(vim.loop.fs_stat, filename)
      if not ok or not stats then
        return
      end

      local size_kb = stats.size / 1024

      if size_kb > LARGE_FILE_SIZE then
        vim.notify(
          string.format("Large markdown file detected (%.1f KB). Disabling some features for performance.", size_kb),
          vim.log.levels.INFO
        )

        -- Disable treesitter for this buffer
        vim.cmd "TSBufDisable highlight"
        vim.cmd "TSBufDisable indent"

        -- Use manual folding instead of treesitter
        vim.opt_local.foldmethod = "manual"

        -- Disable spell checking
        vim.opt_local.spell = false

        -- Disable relative line numbers for performance
        vim.opt_local.relativenumber = false

        -- Disable cursor line
        vim.opt_local.cursorline = false

        -- Set a flag to disable image.nvim for this buffer
        vim.b[bufnr].disable_image_nvim = true

        -- Disable concealing
        vim.opt_local.conceallevel = 0

        -- Use simpler syntax highlighting
        vim.cmd "syntax clear"
        vim.cmd "syntax on"

        -- Detach LSP clients for better performance
        vim.schedule(function()
          local clients = vim.lsp.get_clients { bufnr = bufnr }
          for _, client in ipairs(clients) do
            if client.name == "marksman" or client.name == "markdown_oxide" then
              vim.lsp.buf_detach_client(bufnr, client.id)
              vim.notify("Detached " .. client.name .. " for performance", vim.log.levels.INFO)
            end
          end
        end)
      else
        -- For normal-sized files, just disable markdown_oxide to avoid conflicts
        vim.schedule(function()
          local clients = vim.lsp.get_clients { bufnr = bufnr }
          for _, client in ipairs(clients) do
            -- Keep only marksman, disable markdown_oxide to avoid conflicts
            if client.name == "markdown_oxide" then
              vim.lsp.buf_detach_client(bufnr, client.id)
            end
          end
        end)
      end
    end,
  })

  -- Markdown-specific settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
      -- Better line wrapping
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.breakindent = true

      -- Spell checking (only for small files)
      local size_kb = (vim.fn.getfsize(vim.fn.expand "%") or 0) / 1024
      if size_kb < LARGE_FILE_SIZE then
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
      end

      -- Tab settings
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      vim.opt_local.expandtab = true
    end,
  })

  -- Add a safety mechanism for slow-loading files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function(args)
      local bufnr = args.buf
      local timer = vim.loop.new_timer()

      -- Set a timeout to check if the file is still loading after 2 seconds
      timer:start(
        2000,
        0,
        vim.schedule_wrap(function()
          -- Check if we're still in the same buffer and it's markdown
          if vim.api.nvim_get_current_buf() == bufnr and vim.bo[bufnr].filetype == "markdown" then
            local lines = vim.api.nvim_buf_line_count(bufnr)
            if lines > 1000 then
              vim.notify("Large markdown file detected. Switching to performance mode.", vim.log.levels.WARN)
              vim.cmd "MarkdownPerformanceMode"
            end
          end
          timer:close()
        end)
      )
    end,
  })

  -- Commands for manual control
  vim.api.nvim_create_user_command("MarkdownPerformanceMode", function()
    vim.cmd "TSBufDisable highlight"
    vim.cmd "TSBufDisable indent"
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.spell = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.conceallevel = 0

    -- Detach all LSP clients
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients { bufnr = bufnr }
    for _, client in ipairs(clients) do
      vim.lsp.buf_detach_client(bufnr, client.id)
    end

    vim.notify("Markdown performance mode enabled", vim.log.levels.INFO)
  end, { desc = "Enable performance mode for current markdown buffer" })

  vim.api.nvim_create_user_command("MarkdownNormalMode", function()
    vim.cmd "TSBufEnable highlight"
    vim.cmd "TSBufEnable indent"
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.spell = true
    vim.opt_local.relativenumber = true
    vim.opt_local.cursorline = true
    vim.opt_local.conceallevel = 2

    -- Restart LSP
    vim.cmd "LspStart"

    vim.notify("Markdown normal mode enabled", vim.log.levels.INFO)
  end, { desc = "Disable performance mode for current markdown buffer" })

  -- Diagnostic command to check what might be causing issues
  vim.api.nvim_create_user_command("MarkdownDiagnostics", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local size_kb = (vim.fn.getfsize(filename) or 0) / 1024

    print "=== Markdown Diagnostics ==="
    print("File: " .. filename)
    print(string.format("Size: %.1f KB", size_kb))
    print("Large file threshold: " .. LARGE_FILE_SIZE .. " KB")

    -- Check Treesitter status
    local ts_ok, _ = pcall(require, "nvim-treesitter")
    if ts_ok then
      print "Treesitter: Enabled"
      local highlighter = require "vim.treesitter.highlighter"
      if highlighter.active[bufnr] then
        print "  - Highlighting: Active"
      else
        print "  - Highlighting: Inactive"
      end
    end

    -- Check LSP clients
    local clients = vim.lsp.get_clients { bufnr = bufnr }
    print("LSP Clients (" .. #clients .. "):")
    for _, client in ipairs(clients) do
      print("  - " .. client.name)
    end

    -- Check if image.nvim is disabled
    if vim.b[bufnr].disable_image_nvim then
      print "image.nvim: Disabled for this buffer"
    else
      print "image.nvim: Enabled"
    end

    -- Check fold settings
    print("Fold method: " .. vim.opt_local.foldmethod:get())

    -- Check plugins that might affect markdown
    local plugins = {
      "render-markdown",
      "markdown-preview",
      "image",
    }

    print "Markdown plugins:"
    for _, plugin in ipairs(plugins) do
      local ok, _ = pcall(require, plugin)
      if ok then
        print("  - " .. plugin .. ": Loaded")
      else
        print("  - " .. plugin .. ": Not loaded")
      end
    end
  end, { desc = "Show markdown buffer diagnostics" })
end

-- Call setup
M.setup()

return M
