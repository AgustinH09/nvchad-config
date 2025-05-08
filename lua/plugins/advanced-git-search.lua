return {
  "aaronhallaert/advanced-git-search.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    -- "sindrets/diffview.nvim",
  },
  cmd = { "AdvancedGitSearch" },
  config = function()
    require("telescope").setup {
      extensions = {
        advanced_git_search = {
          browse_command = "GBrowse {commit_hash}",
          diff_plugin = "fugitive",
          git_flags = {},
          git_diff_flags = {},
          git_log_flags = {},
          show_builtin_git_pickers = false,
          entry_default_author_or_date = "author",
          keymaps = {
            toggle_date_author = "<C-w>",
            open_commit_in_browser = "<C-o>",
            copy_commit_hash = "<C-y>",
            show_entire_commit = "<C-e>",
          },
          telescope_theme = {
            function_name_1 = {},
            function_name_2 = "dropdown",
            show_custom_functions = {
              layout_config = { width = 0.4, height = 0.4 },
            },
          },
        },
      },
    }

    require("telescope").load_extension "advanced_git_search"
  end,
  keys = {
    -- Search log content (grep through commit changes)
    {
      "<leader>ga",
      "<cmd>AdvancedGitSearch search_log_content<CR>",
      desc = "All Commits",
    },
    -- File history (commits affecting current file, search content)
    {
      "<leader>gc",
      "<cmd>AdvancedGitSearch search_log_content_file<CR>",
      desc = "Commits",
    },
    -- File history (commits affecting current file, search commit message)
    {
      "<leader>gC",
      "<cmd>AdvancedGitSearch diff_commit_file<CR>",
      desc = "Commits (Filter Message)",
    },
    -- Search log for visual selection
    {
      "<leader>gv",
      "<cmd>'<,'>AdvancedGitSearch diff_commit_line<CR>",
      desc = "Visual selection",
      mode = { "v" },
    },
    -- Search Branchs Changing Current File
    {
      "<leader>gB",
      "<cmd>AdvancedGitSearch changed_on_branch<CR>",
      desc = "Changed File on Current Branch",
    },
    -- Changed files in current branch
    {
      "<leader>gb",
      "<cmd>AdvancedGitSearch diff_branch_file<CR>",
      desc = "Branches",
    },
    -- Checkout from reflog
    {
      "<leader>gr",
      "<cmd>AdvancedGitSearch checkout_reflog<CR>",
      desc = "Reflog",
    },
  },
}
