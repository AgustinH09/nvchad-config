local M = {}

M.setup = function()
  require("mini.animate").setup {
    -- Cursor path
    cursor = {
      -- Whether to enable this animation
      enable = false,
    },
    -- Vertical scroll
    scroll = {
      -- Whether to enable this animation
      enable = true,
    },
    -- Window resize
    resize = {
      -- Whether to enable this animation
      enable = true,
    },
    -- Window open
    open = {
      -- Whether to enable this animation
      enable = true,
    },
    -- Window close
    close = {
      -- Whether to enable this animation
      enable = true,
    },
  }
end

return M
