-- Rust-specific configuration and utilities

local M = {}

M.setup = function()
  -- Rust-specific settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
      -- Rust uses 4 spaces
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
      vim.bo.softtabstop = 4
      vim.bo.expandtab = true

      -- Better for Rust macros
      vim.opt_local.foldmethod = "syntax"
      vim.opt_local.foldlevel = 99
    end,
  })

  -- Cargo commands
  local cargo_commands = {
    { cmd = "build", desc = "Build project" },
    { cmd = "run", desc = "Run project" },
    { cmd = "test", desc = "Run tests" },
    { cmd = "bench", desc = "Run benchmarks" },
    { cmd = "doc", desc = "Generate documentation" },
    { cmd = "clean", desc = "Clean build artifacts" },
    { cmd = "update", desc = "Update dependencies" },
    { cmd = "check", desc = "Check project" },
    { cmd = "fmt", desc = "Format code" },
    { cmd = "clippy", desc = "Run clippy lints" },
    { cmd = "publish", desc = "Publish crate" },
    { cmd = "tree", desc = "Show dependency tree" },
    { cmd = "audit", desc = "Audit dependencies" },
    { cmd = "outdated", desc = "Show outdated dependencies" },
  }

  -- Create Cargo command
  vim.api.nvim_create_user_command("Cargo", function(opts)
    local args = opts.args
    
    -- Save current buffer FIRST if modified (critical for seeing changes!)
    if vim.bo.modified then
      vim.cmd "write"
      -- Small delay to ensure filesystem sync
      vim.wait(50)
    end
    
    local cmd = "cargo " .. args

    -- Run in terminal for interactive commands
    if args:match "^run" or args:match "^test" then
      -- Close any existing terminal buffers to prevent stale output
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name:match "cargo" then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end
      
      -- Open fresh terminal split
      vim.cmd("split | terminal " .. cmd)
      vim.cmd "startinsert" -- Start in terminal mode
    else
      vim.fn.jobstart(cmd, {
        on_stdout = function(_, data)
          if data and data[1] ~= "" then
            vim.notify(table.concat(data, "\n"))
          end
        end,
        on_stderr = function(_, data)
          if data and data[1] ~= "" then
            vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
          end
        end,
      })
    end
  end, {
    nargs = "+",
    complete = function(arglead)
      local completions = {}
      for _, cmd in ipairs(cargo_commands) do
        if cmd.cmd:match("^" .. arglead) then
          table.insert(completions, cmd.cmd)
        end
      end
      return completions
    end,
    desc = "Cargo commands",
  })

  -- Crate.io search
  vim.api.nvim_create_user_command("CrateSearch", function(opts)
    local query = opts.args
    local url = "https://crates.io/search?q=" .. vim.fn.escape(query, " ")
    vim.fn.system("xdg-open " .. url)
    vim.notify("Searching crates.io for: " .. query)
  end, {
    nargs = "+",
    desc = "Search crates.io",
  })

  -- Cargo.toml utilities
  vim.api.nvim_create_user_command("CargoAddDep", function(opts)
    local crate = opts.args
    vim.fn.system("cargo add " .. crate)
    vim.notify("Added dependency: " .. crate)
  end, {
    nargs = "+",
    desc = "Add dependency to Cargo.toml",
  })

  -- Rust playground
  vim.api.nvim_create_user_command("RustPlayground", function()
    local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    local encoded = vim.fn.system("echo " .. vim.fn.shellescape(content) .. " | base64 -w0")
    local url = "https://play.rust-lang.org/?code=" .. encoded
    vim.fn.system("xdg-open " .. url)
    vim.notify "Opened in Rust Playground"
  end, {
    desc = "Open current buffer in Rust Playground",
  })

  -- Rust documentation shortcuts
  vim.api.nvim_create_user_command("RustDoc", function(opts)
    local item = opts.args ~= "" and opts.args or vim.fn.expand "<cword>"
    local url = "https://doc.rust-lang.org/std/?search=" .. item
    vim.fn.system("xdg-open " .. url)
  end, {
    nargs = "?",
    desc = "Search Rust documentation",
  })

  -- Auto-create main function in new files
  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "main.rs",
    callback = function()
      local lines = {
        "fn main() {",
        '    println!("Hello, world!");',
        "}",
      }
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      vim.fn.cursor(2, 5)
    end,
  })

  -- Better error format for cargo
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
      vim.opt_local.errorformat:prepend {
        "%Eerror: %m",
        "%Eerror[E%n]: %m",
        "%Wwarning: %m",
        "%Inote: %m",
        "%-G%f:%l",
        "%-G   |>%m",
        "%-G   |",
      }
    end,
  })
end

-- Call setup
M.setup()

return M
