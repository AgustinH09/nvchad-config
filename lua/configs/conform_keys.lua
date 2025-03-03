local keys = {
  {
    "<leader>tf",
    function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      local status = vim.g.disable_autoformat and "OFF" or "ON"
      vim.notify("Autoformat on save is " .. status)
    end,
    desc = "Toggle autoformat (buffer)",
  },
}

return keys
