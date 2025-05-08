return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  event = "BufReadPre",
  opts = {
    disable_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
    -- restricted_keys = {
    --   ["h"] = {},
    --   ["j"] = {},
    --   ["k"] = {},
    --   ["l"] = {},
    -- },
    max_count = 20,
    -- disabled_keys = {
    --   ["h"] = {},
    --   ["j"] = {},
    --   ["k"] = {},
    --   ["l"] = {},
    -- },
    disable_mouse = false,
  },
}
