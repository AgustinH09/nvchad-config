local M = {}

M.setup = function()
  -- Load the mini.trailspace module
  require("mini.trailspace").setup()

  -- Create an autocommand group for trimming trailing spaces on save
  vim.api.nvim_create_augroup("TrimTrailingSpaceOnSave", { clear = true })

  -- Define the autocommand
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = "TrimTrailingSpaceOnSave",
    pattern = "*",
    callback = function()
      -- Trim trailing whitespace
      require("mini.trailspace").trim()
      -- Optionally, trim final blank lines
      require("mini.trailspace").trim_last_lines()
    end,
  })
end

return M
