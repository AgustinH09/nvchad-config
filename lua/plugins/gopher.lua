return {
  "olexsmir/gopher.nvim",
  ft = "go",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  build = function()
    vim.cmd [[silent! GoInstallDeps]]
  end,
  opts = {
    commands = {
      go = "go",
      gomodifytags = "gomodifytags",
      gotests = "gotests",
      impl = "impl",
      iferr = "iferr",
      dlv = "dlv",
    },
    gotests = {
      -- gotests template
      template = "testify",
      template_dir = nil,
      named = false,
    },
    gotag = {
      transform = "snakecase",
    },
  },
  keys = {
    -- Struct tags
    { "<leader>goj", "<cmd>GoTagAdd json<cr>", desc = "Add json struct tags", ft = "go" },
    { "<leader>goy", "<cmd>GoTagAdd yaml<cr>", desc = "Add yaml struct tags", ft = "go" },
    { "<leader>gox", "<cmd>GoTagAdd xml<cr>", desc = "Add xml struct tags", ft = "go" },
    { "<leader>god", "<cmd>GoTagRm<cr>", desc = "Remove struct tags", ft = "go" },

    -- Tests
    { "<leader>got", "<cmd>GoTestAdd<cr>", desc = "Add test for function", ft = "go" },
    { "<leader>goa", "<cmd>GoTestsAll<cr>", desc = "Add tests for all functions", ft = "go" },
    { "<leader>goT", "<cmd>GoTestsExp<cr>", desc = "Add tests for exported functions", ft = "go" },

    -- Error handling
    { "<leader>goe", "<cmd>GoIfErr<cr>", desc = "Add if err != nil", ft = "go" },

    -- Implementation
    { "<leader>goi", "<cmd>GoImpl<cr>", desc = "Implement interface", ft = "go" },

    -- Go mod
    { "<leader>gomt", "<cmd>GoMod tidy<cr>", desc = "Go mod tidy", ft = "go" },
    { "<leader>gomi", "<cmd>GoMod init<cr>", desc = "Go mod init", ft = "go" },

    -- Generate
    { "<leader>gog", "<cmd>GoGenerate<cr>", desc = "Go generate", ft = "go" },
    { "<leader>goG", "<cmd>GoGenerate %<cr>", desc = "Go generate file", ft = "go" },

    -- Comments
    { "<leader>goc", "<cmd>GoCmt<cr>", desc = "Add comment", ft = "go" },

    -- Build/Install
    { "<leader>gob", "<cmd>GoBuild<cr>", desc = "Go build", ft = "go" },
    { "<leader>goI", "<cmd>GoInstall<cr>", desc = "Go install", ft = "go" },
  },
}
