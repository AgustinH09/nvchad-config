local M = {}

M.setup = function()
  -- Autocmd to remove trailing whitespace on file save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*", -- Apply to all file types
    callback = function()
      -- Save the current cursor position to restore later
      local cursor_pos = vim.api.nvim_win_get_cursor(0)

      -- Remove trailing whitespace
      vim.cmd([[ %s/\s\+$//e ]])

      -- Restore cursor position
      vim.api.nvim_win_set_cursor(0, cursor_pos)
    end,
  })
end

return M

