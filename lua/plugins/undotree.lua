return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  config = function()
    vim.keymap.set("n", "<leader>u", pcall(vim.cmd.UndotreeToggle))
  end,
}
