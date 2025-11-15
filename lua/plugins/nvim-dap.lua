local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

return {
  "mfussenegger/nvim-dap",
  recommended = true,
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jbyuki/one-small-step-for-vimkind",
    "jay-babu/mason-nvim-dap.nvim",
    "./nvim-dap-vscode-js",
    "leoluz/nvim-dap-go",
    "nvim-telescope/telescope-dap.nvim",
  },

  -- stylua: ignore
  keys = {
    -- Basic debugging
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>ds", function() require("dap").terminate() end, desc = "Stop" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },

    -- Stepping
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },

    -- Other
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover Variables" },
    { "<leader>dv", function() require("dap.ui.widgets").preview() end, desc = "Preview" },
    { "<leader>df", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end, desc = "Frames" },
    { "<leader>dx", function()
      require("dap").clear_breakpoints()
      vim.notify("Breakpoints cleared", vim.log.levels.INFO)
    end, desc = "Clear all breakpoints" },
    { "<leader>dL", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end, desc = "Log Point" },

    -- UI
    { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },

    -- Telescope DAP
    { "<leader>dT", "<cmd>Telescope dap commands<cr>", desc = "DAP Commands" },
    { "<leader>dt", "<cmd>Telescope dap configurations<cr>", desc = "DAP Configs" },
    { "<leader>dbb", "<cmd>Telescope dap list_breakpoints<cr>", desc = "List Breakpoints" },
  },

  config = function()
    local dap = require "dap"

    -- Enable DAP logging
    dap.set_log_level "INFO"

    -- User command to open DAP log
    vim.api.nvim_create_user_command("DapLog", function()
      vim.cmd("edit " .. vim.fn.stdpath "cache" .. "/dap.log")
    end, { desc = "Open DAP log file" })

    require("mason-nvim-dap").setup(require "configs.mason-nvim-dap")
    require("dap-go").setup()

    -- Load Telescope DAP extension
    require("telescope").load_extension "dap"

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    local icons = {
      Breakpoint = { "", "DiagnosticError" },
      BreakpointCondition = { "", "DiagnosticWarn" },
      BreakpointRejected = { "", "DiagnosticHint" },
      LogPoint = { "", "DiagnosticInfo" },
    }

    -- Set up DAP signs using your own icons
    for name, sign in pairs(icons) do
      local signData = type(sign) == "table" and sign or { sign }
      -- DAP still uses the old sign_define API
      vim.fn.sign_define("Dap" .. name, {
        text = signData[1],
        texthl = signData[2] or "DiagnosticInfo",
        linehl = signData[3],
        numhl = signData[3],
      })
    end

    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug nodejs processes (ensure the process is started with --inspect)
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch & Debug Chrome",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = "Enter URL: ",
                default = "http://localhost:3000",
              }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived configs
        {
          name = "----- ↓ launch.json configs ↓ -----",
          type = "",
          request = "launch",
        },
      }
    end

    -- Ruby debugging setup
    dap.adapters.ruby = {
      type = "executable",
      command = "bundle",
      args = { "exec", "rdbg", "-n", "--open", "--port", "38698", "-c", "--", "bundle", "exec" },
    }

    dap.configurations.ruby = {
      {
        type = "ruby",
        request = "launch",
        name = "Debug Ruby file",
        program = "${file}",
      },
      {
        type = "ruby",
        request = "attach",
        name = "Attach to rdbg",
        port = 38698,
      },
    }

    -- Setup for parsing VS Code launch.json files
    local vscode = require "dap.ext.vscode"
    local json = require "plenary.json"
    vscode.json_decode = function(str)
      return vim.json.decode(json.json_strip_comments(str))
    end
  end,
}
