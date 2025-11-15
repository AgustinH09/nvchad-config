return {
  "rmagatti/auto-session",
  event = "VimEnter",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_save = true,
    auto_restore = true,
    auto_create = true,

    -- Performance: Only save essential items
    allowed_dirs = nil, -- Allow all directories
    auto_restore_last_session = false, -- Don't restore last session on startup
    use_git_branch = true, -- Separate sessions per git branch

    -- Suppress all session messages for less noise
    suppressed_dirs = { "~/", "~/Downloads", "/tmp" },

    -- Minimal session options for performance
    bypass_save_filetypes = { "alpha", "dashboard", "lazy", "mason", "neo-tree", "NvimTree", "Trouble" },

    -- Close these before saving for cleaner sessions
    close_unsupported_windows = true,

    -- Performance: Conservative settings
    cwd_change_handling = false, -- Don't auto-switch sessions on directory change

    -- Hooks for cleanup
    pre_save_cmds = {
      -- Only include commands that are guaranteed to exist
      "silent! NvimTreeClose",
      function()
        -- Safe close of DAP UI if it exists
        pcall(function()
          require("dapui").close()
        end)
        -- Close all floating windows
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= "" then
            pcall(vim.api.nvim_win_close, win, false)
          end
        end
      end,
    },

    post_restore_cmds = {},

    -- Session lens for telescope integration
    session_lens = {
      load_on_setup = false, -- Don't load on startup for performance
      previewer = false, -- Disable preview for performance
      theme_conf = {
        border = true,
        layout_config = {
          width = 0.8,
          height = 0.6,
        },
      },
    },

    -- Logging
    log_level = "error", -- Only log errors
  },

  keys = {
    -- Manual session management
    { "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save session" },
    { "<leader>sr", "<cmd>SessionRestore<cr>", desc = "Restore session" },
    { "<leader>sd", "<cmd>SessionDelete<cr>", desc = "Delete session" },

    -- Session search with Telescope
    { "<leader>sf", "<cmd>Telescope session-lens search_session<cr>", desc = "Find sessions" },

    -- Quick session switching
    -- { "<leader>sl", "<cmd>SessionRestoreFromFile<cr>", desc = "Restore from file" },
    -- { "<leader>sp", "<cmd>SessionPurgeOrphaned<cr>", desc = "Cleanup orphaned sessions" },

    -- Session info
    {
      "<leader>si",
      function()
        local cwd = vim.fn.getcwd()
        local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
        local session_name = cwd:match "([^/]+)$" or "unknown"

        if branch ~= "" then
          vim.notify(string.format("Project: %s (branch: %s)", session_name, branch), vim.log.levels.INFO)
        else
          vim.notify("Project: " .. session_name, vim.log.levels.INFO)
        end
      end,
      desc = "Show session info",
    },
  },

  config = function(_, opts)
    -- Set session options before loading the plugin
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

    require("auto-session").setup(opts)

    -- Load telescope extension
    require("telescope").load_extension "session-lens"
  end,
}
