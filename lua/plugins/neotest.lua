return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Language specific adapters
    { "fredrikaverpil/neotest-golang", version = "*" },
    "olimorris/neotest-rspec",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-jest",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-vim-test",
    "marilari88/neotest-vitest",
  },
  cmd = { "Neotest" },
  keys = {
    -- Run tests
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      desc = "Run file tests",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last test",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.fn.expand "%:p:h")
      end,
      desc = "Run all tests in dir",
    },

    -- Debug tests
    {
      "<leader>td",
      function()
        require("neotest").run.run { strategy = "dap" }
      end,
      desc = "Debug nearest test",
    },
    {
      "<leader>tD",
      function()
        require("neotest").run.run { vim.fn.expand "%", strategy = "dap" }
      end,
      desc = "Debug file tests",
    },

    -- Control tests
    {
      "<leader>ts",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop test",
    },
    {
      "<leader>tA",
      function()
        require("neotest").run.attach()
      end,
      desc = "Attach to test",
    },

    -- Test output
    {
      "<leader>to",
      function()
        require("neotest").output.open { enter = true, auto_close = true }
      end,
      desc = "Show test output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },

    -- Test summary
    {
      "<leader>tS",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle test summary",
    },

    -- Navigation
    {
      "[t",
      function()
        require("neotest").jump.prev { status = "failed" }
      end,
      desc = "Previous failed test",
    },
    {
      "]t",
      function()
        require("neotest").jump.next { status = "failed" }
      end,
      desc = "Next failed test",
    },

    -- Marks
    {
      "<leader>tm",
      function()
        require("neotest").summary.mark()
      end,
      desc = "Mark test",
    },
    {
      "<leader>tM",
      function()
        require("neotest").summary.clear_marked()
      end,
      desc = "Clear marked tests",
    },
    {
      "<leader>tr",
      function()
        require("neotest").summary.run_marked()
      end,
      desc = "Run marked tests",
    },

    -- Watch mode
    {
      "<leader>tw",
      function()
        require("neotest").watch.toggle(vim.fn.expand "%")
      end,
      desc = "Toggle watch mode",
    },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        -- Go
        require "neotest-golang" {
          experimental = {
            test_table = true,
          },
          args = { "-count=1", "-timeout=60s" },
        },

        -- Ruby/Rails
        require "neotest-rspec" {
          rspec_cmd = function()
            return vim.tbl_flatten {
              "bundle",
              "exec",
              "rspec",
            }
          end,
        },

        -- Python
        require "neotest-python" {
          dap = { justMyCode = false },
          runner = "pytest",
          python = ".venv/bin/python",
        },

        -- JavaScript/TypeScript
        require "neotest-jest" {
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },

        -- Vitest for modern JS/TS projects
        require "neotest-vitest",

        -- Rust
        require "neotest-rust" {
          args = { "--no-capture" },
          dap_adapter = "codelldb",
        },

        -- Fallback for other test runners
        require "neotest-vim-test" {
          ignore_file_types = { "python", "vim", "lua", "javascript", "typescript", "go", "rust", "ruby" },
        },
      },

      -- UI configuration
      diagnostic = {
        enabled = true,
        severity = 1,
      },
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "",
        running = "",
        running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        skipped = "",
        unknown = "",
        watching = "",
      },

      output = {
        enabled = true,
        open_on_run = false,
      },

      output_panel = {
        enabled = true,
        height = 25,
        open = "botright split | resize 15",
      },

      quickfix = {
        enabled = true,
        open = false,
      },

      run = {
        enabled = true,
      },

      running = {
        concurrent = true,
      },

      state = {
        enabled = true,
      },

      status = {
        enabled = true,
        virtual_text = true,
        signs = true,
      },

      strategies = {
        integrated = {
          height = 40,
          width = 120,
        },
      },

      summary = {
        animated = true,
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = "a",
          clear_marked = "M",
          clear_target = "T",
          debug = "d",
          debug_marked = "D",
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          jumpto = "i",
          mark = "m",
          next_failed = "]",
          output = "o",
          prev_failed = "[",
          run = "r",
          run_marked = "R",
          short = "O",
          stop = "u",
          target = "t",
          watch = "w",
        },
        open = "botright vsplit | vertical resize 50",
      },

      watch = {
        enabled = true,
        symbol_queries = {
          go = "        ;query\n        ;Captures imported types\n        (qualified_type name: (type_identifier) @symbol)\n        ;Captures package-local and built-in types\n        (type_identifier)@symbol\n        ;Captures imported function calls and variables/constants\n        (selector_expression field: (field_identifier) @symbol)\n        ;Captures package-local functions calls\n        (call_expression function: (identifier) @symbol)\n      ",
          lua = '        ;query\n        ;Captures module names in require calls\n        (function_call\n          name: ((identifier) @function (#eq? @function "require"))\n          arguments: (arguments (string) @symbol))\n      ',
          python = "        ;query\n        ;Captures imports and modules they're imported from\n        (import_from_statement (_ (identifier) @symbol))\n        (import_statement (_ (identifier) @symbol))\n      ",
        },
      },
    }
  end,
}
