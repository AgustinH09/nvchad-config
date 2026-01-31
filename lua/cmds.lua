vim.g.beepboop_active = false
vim.g.beepboop_profile = vim.g.beepboop_profile or "typewriter"

local plugin_name = "beepboop.nvim"

---
-- COMMAND 1: :BeepBoop (Toggle)
---
vim.api.nvim_create_user_command("BeepBoop", function()
  if vim.g.beepboop_active then
    require("lazy").reset(plugin_name)
    vim.g.beepboop_active = false
    print "BeepBoop plugin disabled."
  else
    require("lazy").load { plugins = plugin_name }
    vim.g.beepboop_active = true
    print("BeepBoop plugin activated (" .. vim.g.beepboop_profile .. " sounds).")
  end
end, {
  desc = "Toggle BeepBoop plugin (load/unload)",
  nargs = 0,
})

---
-- COMMAND 2: :BeepBoopSelect (Change Profile)
---
vim.api.nvim_create_user_command("BeepBoopSelect", function(args)
  local new_profile = args.fargs[1]

  if not new_profile then
    print "Error: No profile provided. Use 'typewriter' or 'minecraft'."
    return
  end

  if new_profile ~= "typewriter" and new_profile ~= "minecraft" then
    print "Invalid profile. Choose 'typewriter' or 'minecraft'."
    return
  end

  vim.g.beepboop_profile = new_profile
  print("BeepBoop profile set to: " .. new_profile)

  if vim.g.beepboop_active then
    print "Reloading BeepBoop with new sounds..."

    require("lazy").reset(plugin_name)
    require("lazy").load { plugins = plugin_name }
  end
end, {
  desc = "Set BeepBoop sound profile [typewriter|minecraft]",
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    return { "typewriter", "minecraft" }
  end,
})

---
-- COMMAND 3: LSP Log Management
---
vim.api.nvim_create_user_command("LspLogSize", function()
  local log_path = vim.lsp.get_log_path()
  local stat = vim.loop.fs_stat(log_path)

  if stat then
    local size_mb = stat.size / (1024 * 1024)
    print(string.format("LSP Log Size: %.2f MB (%s)", size_mb, log_path))
  else
    print("LSP log file not found at: " .. log_path)
  end
end, { desc = "Show current LSP log file size" })

vim.api.nvim_create_user_command("LspLogClear", function()
  local log_path = vim.lsp.get_log_path()
  local f = io.open(log_path, "w")
  if f then
    f:close()
    print "LSP Log cleared successfully."
  else
    print "Failed to open LSP log for writing."
  end
end, { desc = "Truncate/Clear the LSP log file" })
