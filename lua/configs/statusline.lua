-- Custom statusline component for format-on-save indicator
local M = {}

M.format_indicator = function()
  local global_disabled = vim.g.disable_autoformat
  local buffer_disabled = vim.b.disable_autoformat

  if buffer_disabled then
    return " 󰉶 " -- Formatting disabled for buffer
  elseif global_disabled then
    return " 󰉵 " -- Formatting disabled globally
  else
    return " 󰉼 " -- Formatting enabled
  end
end

-- You can add this to your NvChad statusline by modifying the theme
-- or using it in a custom statusline setup

return M
