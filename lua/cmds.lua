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
