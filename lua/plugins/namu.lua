return {
  "bassamsdata/namu.nvim",
  lazy = false,
  config = function()
    require("namu").setup {
      -- Enable the modules you want
      namu_symbols = {
        enable = true,
        options = {
          AllowKinds = {
            default = {
              "Function",
              "Method",
              "Class",
              "Module",
              "Property",
              "Variable",
              "Constant",
              "Enum",
              "Interface",
              "Field",
              "Struct",
            },
            go = {
              "Function",
              "Method",
              "Struct", -- For struct definitions
              "Field", -- For struct fields
              "Interface",
              "Constant",
              -- "Variable",
              "Property",
              -- "TypeParameter", -- For type parameters if using generics
            },
            lua = { "Function", "Method", "Table", "Module" },
            python = { "Function", "Class", "Method" },
            -- Filetype specific
            yaml = { "Object", "Array" },
            json = { "Module" },
            toml = { "Object" },
            markdown = { "String" },
          },
          BlockList = {
            default = {},
            -- Filetype-specific
            lua = {
              "^vim%.", -- anonymous functions passed to nvim api
              "%.%.%. :", -- vim.iter functions
              ":gsub", -- lua string.gsub
              "^callback$", -- nvim autocmds
              "^filter$",
              "^map$", -- nvim keymaps
            },
            -- another example:
            -- python = { "^__" }, -- ignore __init__ functions
          },
          display = {
            mode = "icon", -- "icon" or "raw"
            padding = 2,
          },
          -- This is a preset that let's set window without really get into the hassle of tuning window options
          -- top10 meaning top 10% of the window
          row_position = "top10", -- options: "center"|"top10"|"top10_right"|"center_right"|"bottom",
          preview = {
            highlight_on_move = true, -- Whether to highlight symbols as you move through them
            -- still needs implmenting, keep it always now
            highlight_mode = "always", -- "always" | "select" (only highlight when selecting)
          },
          window = {
            auto_size = true,
            min_height = 1,
            min_width = 20,
            max_width = 120,
            max_height = 30,
            padding = 2,
            border = "rounded",
            title_pos = "left",
            show_footer = true,
            footer_pos = "right",
            relative = "editor",
            style = "minimal",
            width_ratio = 0.6,
            height_ratio = 0.6,
            title_prefix = "󱠦 ",
          },
          debug = false,
          focus_current_symbol = true,
          auto_select = false,
          initially_hidden = false,
          multiselect = {
            enabled = true,
            indicator = "✓", -- or "✓"●
            keymaps = {
              toggle = "<Tab>",
              untoggle = "<S-Tab>",
              select_all = "<C-a>",
              clear_all = "<C-l>",
            },
            max_items = nil, -- No limit by default
          },
          actions = {
            close_on_yank = false, -- Whether to close picker after yanking
            close_on_delete = true, -- Whether to close picker after deleting
          },
          movement = { -- Support multiple keys
            next = { "<C-n>", "<DOWN>" },
            previous = { "<C-p>", "<UP>" },
            close = { "<ESC>" }, -- "<C-c>" can be added as well
            select = { "<CR>" },
            delete_word = {}, -- it can assign "<C-w>"
            clear_line = {}, -- it can be "<C-u>"
          },
          custom_keymaps = {
            yank = {
              keys = { "<C-y>" },
              desc = "Yank symbol text",
            },
            delete = {
              keys = { "<C-d>" },
              desc = "Delete symbol text",
            },
            vertical_split = {
              keys = { "<C-v>" },
              desc = "Open in vertical split",
            },
            horizontal_split = {
              keys = { "<C-h>" },
              desc = "Open in horizontal split",
            },
            codecompanion = {
              keys = "<C-o>",
              desc = "Add symbol to CodeCompanion",
            },
            avante = {
              keys = "<C-t>",
              desc = "Add symbol to Avante",
            },
          },
          icon = "󱠦", -- 󱠦 -  -  -- 󰚟
          kindText = {
            Function = "function",
            Class = "class",
            Module = "module",
            Constructor = "constructor",
            Interface = "interface",
            Property = "property",
            Field = "field",
            Enum = "enum",
            Constant = "constant",
            Variable = "variable",
          },
          kindIcons = {
            File = "󰈙",
            Module = "󰏗",
            Namespace = "󰌗",
            Package = "󰏖",
            Class = "󰌗",
            Method = "󰆧",
            Property = "󰜢",
            Field = "󰜢",
            Constructor = "󰆧",
            Enum = "󰒻",
            Interface = "󰕘",
            Function = "󰊕",
            Variable = "󰀫",
            Constant = "󰏿",
            String = "󰀬",
            Number = "󰎠",
            Boolean = "󰨙",
            Array = "󰅪",
            Object = "󰅩",
            Key = "󰌋",
            Null = "󰟢",
            EnumMember = "󰒻",
            Struct = "󰌗",
            Event = "󰉁",
            Operator = "󰆕",
            TypeParameter = "󰊄",
          },
          highlight = "NamuPreview",
          highlights = {
            parent = "NamuParent",
            nested = "NamuNested",
            style = "NamuStyle",
          },
          kinds = {
            prefix_kind_colors = true,
            enable_highlights = true,
            highlights = {
              PrefixSymbol = "NamuPrefixSymbol",
              Function = "NamuSymbolFunction",
              Method = "NamuSymbolMethod",
              Class = "NamuSymbolClass",
              Interface = "NamuSymbolInterface",
              Variable = "NamuSymbolVariable",
              Constant = "NamuSymbolConstant",
              Property = "NamuSymbolProperty",
              Field = "NamuSymbolField",
              Enum = "NamuSymbolEnum",
              Module = "NamuSymbolModule",
            },
          },
        },
      },
      colorscheme = {
        enable = false,
      },
    }
    -- === Suggested Keymaps: ===
    vim.keymap.set("n", "<leader>ss", ":Namu symbols<cr>", {
      desc = "Jump to LSP symbol",
      silent = true,
    })
    vim.keymap.set("n", "<leader>tn", ":Namu colorscheme<cr>", {
      desc = "Colorscheme Picker",
      silent = true,
    })
  end,
}
