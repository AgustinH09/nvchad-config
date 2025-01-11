local M = {}

M.setup = function()
  -- Enable NERDCommenter to create default mappings
  vim.g.NERDCreateDefaultMappings = 1

  -- Use compact syntax for comments when possible
  vim.g.NERDCompactSexyComs = 1

  -- Align the comments to the same position
  vim.g.NERDDefaultAlign = 'left'

  -- Enable trimming of trailing whitespace when commenting
  vim.g.NERDTrimTrailingWhitespace = 1

  -- Use space for comment delimiters instead of tabs
  vim.g.NERDTabsToSpaces = 1

  -- Enable commenting of empty lines
  vim.g.NERDCommentEmptyLines = 1

  -- Add a toggle comment mapping
  vim.g.NERDToggleCheckAllLines = 1
end

return M

