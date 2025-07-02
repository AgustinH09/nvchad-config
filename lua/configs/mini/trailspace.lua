local M = {}

M.setup = function()
  require("mini.trailspace").setup()

  vim.api.nvim_create_augroup("TrimTrailingSpaceOnSave", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = "TrimTrailingSpaceOnSave",
    pattern = "*",
    callback = function()
      require("mini.trailspace").trim()
      local last_non_empty_line = vim.fn.prevnonblank(vim.fn.line "$")
      local total_lines = vim.fn.line "$"
      if last_non_empty_line < total_lines then
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        pcall(vim.cmd, string.format("silent! %d,$d", last_non_empty_line + 1))
        pcall(vim.cmd, "silent! $put _")
        vim.api.nvim_win_set_cursor(0, cursor_pos)
      end
    end,
  })
end

return M
