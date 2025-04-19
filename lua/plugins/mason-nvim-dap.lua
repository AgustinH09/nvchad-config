return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = "mason.nvim",
  cmd = { "DapInstall", "DapUninstall" },
  opts = { require "configs.mason-nvim-dap" },
  -- mason-nvim-dap is loaded when nvim-dap loads
  config = function() end,
}
