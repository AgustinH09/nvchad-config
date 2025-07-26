return {
  "3rd/image.nvim",
  ft = { "markdown", "vimwiki", "norg" },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  config = function()
    local image = require("image")

    -- Override the setup to check for our disable flag
    local original_setup = image.setup
    image.setup = function(opts)
      -- Wrap the original rendering functions to check our flag
      local original_render = image.render
      if original_render then
        image.render = function(...)
          local bufnr = vim.api.nvim_get_current_buf()
          if vim.b[bufnr].disable_image_nvim then
            return
          end
          return original_render(...)
        end
      end

      -- Call original setup with modified options
      original_setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = false, -- Disabled for performance
            only_render_image_at_cursor = true, -- Only render at cursor for performance
            filetypes = { "markdown", "vimwiki" },
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = false,
            only_render_image_at_cursor = true,
            filetypes = { "norg" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        kitty_method = "normal",

        -- Performance optimizations
        window_overlap_clear_enabled = false, -- Disable for performance
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

        -- Hijack buffer options
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
      })
    end

    -- Initialize with our wrapped setup
    image.setup({})
  end,
}
