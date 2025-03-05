return {
  "kevinhwang91/nvim-bqf",
  event = "FileType qf",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
    {
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end,
    },
  },
  opts = {
    preview = {
      auto_preview = false,
    },
  },
}
