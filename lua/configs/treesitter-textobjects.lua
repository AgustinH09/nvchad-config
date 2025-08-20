return {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- Functions
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",

        -- Classes
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Conditionals
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",

        -- Loops
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",

        -- Parameters/Arguments
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",

        -- Comments
        ["aC"] = "@comment.outer",
        ["iC"] = "@comment.inner",

        -- Blocks
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",

        -- Statements
        ["as"] = "@statement.outer",
      },
      selection_modes = {
        ["@function.outer"] = "V", -- Line-wise
        ["@class.outer"] = "V", -- Line-wise
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sp"] = "@parameter.inner",
        ["<leader>sf"] = "@function.outer",
      },
      swap_previous = {
        ["<leader>sP"] = "@parameter.inner",
        ["<leader>sF"] = "@function.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.inner",
        ["]i"] = "@conditional.outer",
        ["]l"] = "@loop.outer",
        ["]s"] = "@statement.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]A"] = "@parameter.inner",
        ["]I"] = "@conditional.outer",
        ["]L"] = "@loop.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.inner",
        ["[i"] = "@conditional.outer",
        ["[l"] = "@loop.outer",
        ["[s"] = "@statement.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[A"] = "@parameter.inner",
        ["[I"] = "@conditional.outer",
        ["[L"] = "@loop.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = "rounded",
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}
