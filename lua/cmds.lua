# BeepBoop Toggle Command
vim.g.beepboop_active = false

vim.api.nvim_create_user_command("BeepBoop", function()
    if vim.g.beepboop_active then
        require("lazy").reset("beepboop.nvim")
        vim.g.beepboop_active = false
        print("BeepBoop plugin disabled.")
    else
        require("lazy").load({ plugins = "beepboop.nvim" })
        vim.g.beepboop_active = true
        print("BeepBoop plugin activated.")
    end
end, { desc = "Toggle beepboop.nvim (load/unload)" })
