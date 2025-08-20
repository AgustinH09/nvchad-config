-- Ruby-specific configuration and utilities

local M = {}

M.setup = function()
  -- Ruby-specific settings
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "ruby", "eruby" },
    callback = function()
      -- Ruby uses 2 spaces
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.softtabstop = 2
      vim.bo.expandtab = true

      -- Better Ruby syntax highlighting
      vim.cmd [[syntax sync fromstart]]

      -- Set Ruby-specific format options
      vim.opt_local.formatoptions:remove("o") -- Don't continue comments with o/O
    end,
  })

  -- Custom commands for Ruby development
  vim.api.nvim_create_user_command("RubyEval", function(opts)
    local line = opts.args ~= "" and opts.args or vim.fn.getline(".")
    local result = vim.fn.system("ruby -e '" .. line:gsub("'", "\\'") .. "'")
    vim.notify(result, vim.log.levels.INFO)
  end, {
    nargs = "?",
    desc = "Evaluate Ruby code",
  })

  -- Ruby REPL integration
  vim.api.nvim_create_user_command("RubyRepl", function()
    vim.cmd("terminal irb")
  end, { desc = "Open Ruby REPL (irb)" })

  -- Bundle commands
  vim.api.nvim_create_user_command("Bundle", function(opts)
    local cmd = "bundle " .. opts.args
    vim.fn.jobstart(cmd, {
      on_stdout = function(_, data)
        if data[1] ~= "" then
          vim.notify(table.concat(data, "\n"))
        end
      end,
      on_stderr = function(_, data)
        if data[1] ~= "" then
          vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
        end
      end,
    })
  end, {
    nargs = "+",
    complete = function()
      return { "install", "update", "exec", "add", "remove", "outdated", "show" }
    end,
    desc = "Bundle commands",
  })

  -- RuboCop integration
  vim.api.nvim_create_user_command("RuboCop", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd = "rubocop " .. args .. " " .. vim.fn.expand("%")
    vim.fn.jobstart(cmd, {
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("RuboCop: No offenses detected", vim.log.levels.INFO)
        else
          vim.cmd("copen")
        end
      end,
    })
  end, {
    nargs = "*",
    desc = "Run RuboCop on current file",
  })

  -- Auto-insert frozen string literal
  vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.rb",
    callback = function()
      local first_line = vim.fn.getline(1)
      if first_line == "" then
        vim.fn.setline(1, "# frozen_string_literal: true")
        vim.fn.append(1, "")
        vim.fn.cursor(3, 1)
      end
    end,
  })
end

-- Call setup
M.setup()

return M
