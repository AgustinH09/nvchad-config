return {
  "chrisgrieser/nvim-scissors",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = { "ScissorsAddNewSnippet", "ScissorsEditSnippet" },
  keys = {
    {
      "<leader>sa",
      function()
        require("scissors").addNewSnippet()
      end,
      mode = { "n", "x" },
      desc = "Snippet: Add",
    },
    {
      "<leader>se",
      function()
        require("scissors").editSnippet()
      end,
      mode = "n",
      desc = "Snippet: Edit",
    },
  },
  opts = {
    snippetDir = vim.fn.stdpath "config" .. "/snippets",
  },
}
