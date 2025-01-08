require "nvchad.options"

-- add yours here!

--local o = vim.o
--o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.mouse = "a"
-- Undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]
