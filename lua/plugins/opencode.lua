return {
  "sudo-tee/opencode.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>c", group = "Opencode" },
    { "<leader>cg", desc = "Toggle Opencode window" },
    { "<leader>ci", desc = "Open input window" },
    { "<leader>cI", desc = "Open input (new session)" },
    { "<leader>ch", desc = "Select from history" },
    { "<leader>co", desc = "Open output window" },
    { "<leader>ct", desc = "Toggle focus" },
    { "<leader>cT", desc = "Session timeline" },
    { "<leader>cq", desc = "Close Opencode window" },
    { "<leader>cs", desc = "Select session" },
    { "<leader>cR", desc = "Rename session" },
    { "<leader>cp", desc = "Configure provider" },
    { "<leader>cV", desc = "Configure model variant" },
    { "<leader>cy", desc = "Add visual selection to context", mode = { "v" } },
    { "<leader>cz", desc = "Toggle zoom" },
    { "<leader>cv", desc = "Paste image from clipboard" },
    { "<leader>cd", desc = "Open diff view" },
    { "<leader>c]", desc = "Next diff" },
    { "<leader>c[", desc = "Previous diff" },
    { "<leader>cc", desc = "Close diff view" },
  },
  config = function()
    require("opencode").setup {
      keymap_prefix = "<leader>c",
    }

    -- Set up which-key group
    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.add {
        { "<leader>c", group = "Opencode" },
      }
    end

    -- Fix for session file changing the working directory to the home directory
    -- This forces the working directory to stay as the project root
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "opencode", "opencode_output" },
      callback = function()
        local ok, state = pcall(require, "opencode.state")
        if ok and state.current_cwd then
          vim.cmd("lcd " .. vim.fn.fnameescape(state.current_cwd))
        end
      end,
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
    "nvim-telescope/telescope.nvim",
  },
}
