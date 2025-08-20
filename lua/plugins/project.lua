return {
  "ahmedkhalf/project.nvim",
  dependencies = "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  config = function()
    require("project_nvim").setup {
      manual_mode = false,

      -- Methods of detecting the root directory. **"lsp"** uses the native neovim
      -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
      -- order matters: if one is not detected, the other is used as fallback. You
      -- can also delete or rearangne the detection methods.
      detection_methods = { "lsp", "pattern" },

      -- All the patterns used to detect root dir, when **"pattern"** is in
      -- detection_methods
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

      -- Table of lsp clients to ignore by name
      -- eg: { "efm", ... }
      ignore_lsp = {},

      -- Don't calculate root dir on specific directories
      -- Ex: { "~/.cargo/*", ... }
      exclude_dirs = {},

      -- Show hidden files in telescope
      show_hidden = false,

      -- When set to false, you will get a message when project.nvim changes your
      -- directory.
      silent_chdir = true,

      -- What scope to change the directory, valid options are
      -- * global (default)
      -- * tab
      -- * win
      scope_chdir = "global",

      -- Path where project.nvim will store the project history for use in
      -- telescope
      datapath = vim.fn.stdpath "data",
    }

    -- Integrate with telescope
    require("telescope").load_extension("projects")

    -- Hook into directory changes to save/restore sessions
    local group = vim.api.nvim_create_augroup("ProjectNvimSession", { clear = true })
    vim.api.nvim_create_autocmd("DirChanged", {
      group = group,
      callback = function()
        -- Small delay to ensure project.nvim has finished
        vim.defer_fn(function()
          local auto_session = require("auto-session")
          if auto_session then
            -- Try to restore session for new directory
            auto_session.RestoreSessionFromDir(vim.fn.getcwd())
          end
        end, 100)
      end,
    })
  end,
}
