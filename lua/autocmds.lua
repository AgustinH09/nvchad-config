require "nvchad.autocmds"

-- To add any extra autocmds you can use the nvim_create_augroup and nvim_create_autocmd functions

-- Example of using vim.defer_fn for non-critical autocmds:
-- vim.defer_fn(function()
--   vim.api.nvim_create_autocmd("FileType", {
--     pattern = "python",
--     callback = function()
--       vim.opt_local.expandtab = true
--       vim.opt_local.shiftwidth = 4
--     end,
--   })
-- end, 100)

-- Command to install all mason packages from chadrc
vim.api.nvim_create_user_command("MasonInstallFromList", function()
  -- Get the package list from chadrc
  local chadrc = require "chadrc"
  local packages = chadrc.mason and chadrc.mason.pkgs or {}

  if #packages == 0 then
    vim.notify("No packages configured in chadrc.mason.pkgs", vim.log.levels.WARN)
    return
  end

  -- Check if MasonInstall command exists
  if vim.fn.exists ":MasonInstall" == 2 then
    local package_string = table.concat(packages, " ")
    vim.cmd("MasonInstall " .. package_string)
  else
    vim.notify("Mason not loaded yet. Try running :Mason first", vim.log.levels.ERROR)
  end
end, { desc = "Install all packages listed in chadrc.mason.pkgs" })

-- Install mason packages after lazy.nvim finishes loading
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    -- Only run MasonInstallAll if it exists (NvChad command)
    vim.defer_fn(function()
      if vim.fn.exists ":MasonInstallAll" == 2 then
        vim.cmd "MasonInstallAll"
      end
    end, 100)
  end,
})
