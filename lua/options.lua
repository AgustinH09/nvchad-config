require "nvchad.options"

-- UI / UX tweaks
vim.opt.mouse = "a"
if not vim.g.vscode then
  pcall(vim.cmd, [[let &t_Cs = "\e[4:3m"]]) -- undercurl start
  pcall(vim.cmd, [[let &t_Ce = "\e[4:0m"]]) -- undercurl end
else
  vim.cmd [[let &t_Cs = "\e[4:3m"]] -- undercurl start
  vim.cmd [[let &t_Ce = "\e[4:0m"]] -- undercurl end
end

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.laststatus = 3 -- global statusline
vim.opt.conceallevel = 2 -- Obsidian-style concealing

-- Filetype detection
vim.filetype.add {
  extension = {
    rasi = "rasi",
    rofi = "rasi",
    wofi = "rasi",
  },
  filename = {
    vifmrc = "vim",
    Gemfile = "ruby",
    ["*.gemspec"] = "ruby",
    Rakefile = "ruby",
    Capfile = "ruby",
  },
  pattern = {
    [".*/waybar/config"] = "jsonc",
    [".*/mako/config"] = "dosini",
    [".*/kitty/.+%.conf"] = "kitty",
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".*/%.config/hypr/.+%.conf"] = "hyprlang",
    ["%.env%.[%w_.-]+"] = "sh",
  },
}

-- Treesitter enhancements
vim.treesitter.language.register("bash", "kitty")

-- LuaSnip load snippets (deferred for better startup)
vim.defer_fn(function()
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets" } }
end, 100)

-- Session management settings
vim.opt.sessionoptions:append("localoptions")
vim.opt.sessionoptions:remove("options")
vim.opt.sessionoptions:remove("globals")
