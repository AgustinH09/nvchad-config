return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  branch = "harpoon2",
  keys = {
    {
      "<C-e>",
      function()
        local harpoon = require("harpoon")
        local file_paths = {}
        for _, item in ipairs(harpoon:list().items) do
          table.insert(file_paths, item.value)
        end
        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({ results = file_paths }),
          previewer = require("telescope.config").values.file_previewer({}),
          sorter = require("telescope.config").values.generic_sorter({}),
        }):find()
      end,
      desc = "Open Harpoon window"
    },
    { "<leader>a", function() require("harpoon"):list():add() end, desc = "Add file to Harpoon" },
    { "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Previous Harpoon buffer" },
    { "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Next Harpoon buffer" },
  },
  config = function()
    require("harpoon").setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 20,
      }
    })
  end,
}
