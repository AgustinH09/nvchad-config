return {
  "andythigpen/nvim-coverage",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "Coverage",
    "CoverageLoad",
    "CoverageToggle",
    "CoverageSummary",
    "CoverageShow",
    "CoverageHide",
    "CoverageClear",
  },
  keys = {
    { "<leader>Tc", "<cmd>Coverage<cr>", desc = "Load and display coverage" },
    { "<leader>TC", "<cmd>CoverageToggle<cr>", desc = "Toggle coverage display" },
    { "<leader>Tcs", "<cmd>CoverageSummary<cr>", desc = "Coverage summary" },
  },
  config = function()
    require("coverage").setup {
      commands = true,
      highlights = {
        -- customize highlight groups
        covered = { fg = "#C3E88D" },
        uncovered = { fg = "#F07178" },
        partial = { fg = "#FFCB6B" },
      },
      signs = {
        -- customize signs
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
        partial = { hl = "CoveragePartial", text = "▎" },
      },
      summary = {
        -- customize the summary pop-up
        min_coverage = 80.0,
      },
      lang = {
        -- customize language specific settings
        python = {
          coverage_file = ".coverage",
          coverage_command = "coverage json -q -o -",
        },
        javascript = {
          coverage_file = "coverage/lcov.info",
        },
        typescript = {
          coverage_file = "coverage/lcov.info",
        },
        go = {
          coverage_file = "coverage.out",
          coverage_command = "go test -coverprofile=coverage.out ./...",
        },
        rust = {
          coverage_file = "lcov.info",
          coverage_command = "cargo tarpaulin --out Lcov",
        },
        ruby = {
          coverage_file = "coverage/.resultset.json",
          coverage_command = "bundle exec rspec",
        },
      },
    }
  end,
}
