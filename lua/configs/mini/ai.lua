local M = {}

M.setup = function()
  local gen_spec = require("mini.ai").gen_spec
  local spec_pair = gen_spec.pair

  local function pair(left, right)
    if right == nil then
      right = left
    end

    return spec_pair(left, right, { type = "balanced" })
  end

  local custom_textobjects = {
    -- b = pair("(", ")"),
    -- B = pair("{", "}"),
    -- r = pair("[", "]"),
    -- q = pair "'",
    -- Q = pair '"',
    -- a = pair "`",

    f = gen_spec.treesitter { a = "@function.outer", i = "@function.inner" },
    [";"] = gen_spec.treesitter { a = "@comment.outer", i = "@comment.outer" },

    g = function()
      return {
        from = { line = 1, col = 1 },
        to = {
          line = vim.fn.line "$",
          col = math.max(vim.fn.getline("$"):len(), 1),
        },
      }
    end,
  }
  require("mini.ai").setup {
    custom_textobjects = custom_textobjects,

    mappings = {
      around = "a",
      inside = "i",

      -- Next/last variants
      around_next = "an",
      inside_next = "in",
      around_last = "al",
      inside_last = "il",

      goto_left = "g[",
      goto_right = "g]",
    },
    n_lines = 50,
    search_method = "cover_or_next",
    silent = false,
  }
end

return M
