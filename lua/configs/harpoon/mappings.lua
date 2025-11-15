-- lua/plugins/harpoon.lua

local harpoon = require "harpoon"
local map = vim.keymap.set

-- Function to toggle Telescope with Harpoon files
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = require("telescope.config").values.file_previewer {},
      sorter = require("telescope.config").values.generic_sorter {},
    })
    :find()
end

-- Keybindings for Harpoon
map("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open Harpoon window" })
map("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "Add file to Harpoon" })
--map("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Select Harpoon file 1" })
--map("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Select Harpoon file 2" })
--map("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Select Harpoon file 3" })
--map("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Select Harpoon file 4" })
map("n", "<C-S-P>", function()
  harpoon:list():prev()
end, { desc = "Previous Harpoon buffer" })
map("n", "<C-S-N>", function()
  harpoon:list():next()
end, { desc = "Next Harpoon buffer" })
