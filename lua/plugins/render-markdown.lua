return {
  "MeanderingProgrammer/render-markdown.nvim",
  cmd = { "RenderMarkdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("obsidian").get_client().opts.ui.enable = false
    vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()["ObsidianUI"], 0, -1)
    require("render-markdown").setup {}
  end,
}
