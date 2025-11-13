return {
  "DrKJeff16/project.nvim",
  dependencies = "nvim-telescope/telescope.nvim",
  cmd = {
    "Project",
    "ProjectAdd",
    "ProjectConfig",
    "ProjectDelete",
    "ProjectHistory",
    "ProjectRecents",
    "ProjectRoot",
    "ProjectSession",
  },
  opts = {
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    ignore_lsp = {},
    exclude_dirs = {},
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath "data",
  },
  config = function()
    require("project").setup()
    -- Integrate with telescope
    local status_ok, telescope = pcall(require, "telescope")
    if status_ok then
      telescope.load_extension "projects"
    end

    -- Hook into directory changes to save/restore sessions
    local group = vim.api.nvim_create_augroup("ProjectNvimSession", { clear = true })
    vim.api.nvim_create_autocmd("DirChanged", {
      group = group,
      callback = function()
        vim.defer_fn(function()
          local status_ok, auto_session = pcall(require, "auto-session")
          if not status_ok then
            return
          end

          -- Support for auto-session v2
          if auto_session.restore_session then
            auto_session.restore_session()
          elseif auto_session.RestoreSessionFromDir then
            auto_session.RestoreSessionFromDir(vim.fn.getcwd())
          end
        end, 100)
      end,
    })
  end,
}
