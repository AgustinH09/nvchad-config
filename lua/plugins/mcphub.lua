return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
  },
  -- comment the following line to ensure hub will be ready at the earliest
  cmd = "MCPHub", -- lazy load by default
  build = "npm install -g mcp-hub@latest",
  config = function()
    require("mcphub").setup {
      auto_toggle_mcp_servers = true,
      auto_approve = true,
      extensions = {
        avante = {
          show_result_in_chat = true,
          make_slash_commands = true,
          make_vars = true,
        },
      },
    }
  end,
}
