require "nvchad.options"

-- UI / UX tweaks
vim.opt.mouse = "a"
vim.cmd [[let &t_Cs = "\e[4:3m"]] -- undercurl start
vim.cmd [[let &t_Ce = "\e[4:0m"]] -- undercurl end
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.laststatus = 3 -- global statusline
vim.opt.conceallevel = 1 -- Obsidian-style concealing

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

-- LuaSnip load snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets" } }
