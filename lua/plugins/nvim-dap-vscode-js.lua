return {
  "mxsdev/nvim-dap-vscode-js",
  dependencies = {
    {
      "microsoft/vscode-js-debug",
      -- After install, build it and rename the dist directory to out
      build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      version = "1.*",
    },
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("dap-vscode-js").setup {
      -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      -- node_path = "node",

      -- Path to vscode-js-debug installation.
      debugger_path = vim.fn.resolve(vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"),

      -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
      -- debugger_cmd = { "js-debug-adapter" },

      -- which adapters to register in nvim-dap
      adapters = {
        "chrome",
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "pwa-extensionHost",
        "node-terminal",
      },

      -- Path for file logging
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

      -- Logging level for output to file. Set to false to disable logging.
      -- log_file_level = false,

      -- Logging level for output to console. Set to false to disable console output.
      -- log_console_level = vim.log.levels.ERROR,
    }
  end,
}
