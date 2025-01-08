local M = {}

M.setup = function()
  require("mini.trailspace").setup()

  vim.api.nvim_create_augroup("TrimTrailingSpaceOnSave", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = "TrimTrailingSpaceOnSave",
    pattern = "*",
    callback = function()
      require("mini.trailspace").trim()
      --local last_non_empty_line = vim.fn.prevnonblank(vim.fn.line('$'))
      --vim.cmd(string.format("silent! %d,$d", last_non_empty_line + 1))
      --vim.cmd("silent! $put _")
    end,
  })
end

return M
