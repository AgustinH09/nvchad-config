-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

M.plugins = {
  ["nvim-telescope/telescope.nvim"] = {
    override_options = function()
      return {
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            height = 0.05,
            prompt_position = "top",
            vertical = {
              mirror = true,
              preview_cutoff = 0,
            },
          },
        },
      }
    end,
  },
}
return M
