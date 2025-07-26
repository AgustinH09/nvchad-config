return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "fredrikaverpil/neotest-golang", version = "*" },
    "olimorris/neotest-rspec",
  },
  cmd = { "Neotest" },
  keys = {
    { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
    { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug nearest test" },
    { "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop test" },
    { "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to test" },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-golang",
        require "neotest-rspec",
      },
    }
  end,
}
