return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  enabled = false, -- Disabled: Using blink-cmp's signature feature instead
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}
