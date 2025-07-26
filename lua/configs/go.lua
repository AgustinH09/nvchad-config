-- Go-specific configuration and utilities

local M = {}

-- Configure Go environment
M.setup = function()
  -- Set up Go-specific options
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
      -- Tab settings for Go
      vim.bo.expandtab = false
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4

      -- Better quickfix for Go
      vim.bo.errorformat = vim.bo.errorformat .. ",%f:%l:%c: %m"

      -- Auto-organize imports on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          -- Organize imports using gopls
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { "source.organizeImports" } }
          local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end
        end,
      })
    end,
  })

  -- Custom commands
  vim.api.nvim_create_user_command("GoAlternate", function()
    local file = vim.fn.expand("%:p")
    local alt_file

    if file:match("_test%.go$") then
      -- Test file -> implementation file
      alt_file = file:gsub("_test%.go$", ".go")
    else
      -- Implementation file -> test file
      alt_file = file:gsub("%.go$", "_test.go")
    end

    if vim.fn.filereadable(alt_file) == 1 then
      vim.cmd("edit " .. alt_file)
    else
      vim.notify("Alternate file not found: " .. alt_file, vim.log.levels.WARN)
    end
  end, { desc = "Switch between Go file and its test" })

  -- Add Go workspace commands
  vim.api.nvim_create_user_command("GoWork", function(opts)
    local cmd = "go work " .. opts.args
    vim.fn.system(cmd)
    vim.notify("Executed: " .. cmd)
  end, {
    nargs = "+",
    complete = function()
      return { "init", "use", "edit", "sync" }
    end,
    desc = "Go workspace commands",
  })
end

-- Call setup when this module is loaded
M.setup()

return M
