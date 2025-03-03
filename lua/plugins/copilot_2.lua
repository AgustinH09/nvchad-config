return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      copilot_node_command = "/home/chicha09/.local/share/mise/installs/node/22.12.0/bin/node",
    }
  end,
}
