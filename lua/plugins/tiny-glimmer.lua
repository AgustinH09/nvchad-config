-- Add type to opts
return {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  enabled = false,
  opts = {
    enabled = true,
    disable_warnings = true,
    default_animation = "fade",
    refresh_interval_ms = 6,

    overwrite = {
      auto_map = true,
      -- default_animation = {
      --     name = "fade",
      --
      --     settings = {
      --         max_duration = 1000,
      --         min_duration = 1000,
      --
      --         from_color = "DiffDelete",
      --         to_color = "Normal",
      --     },
      -- },
      search = {
        enabled = true,
        default_animation = "rainbow",

        -- Keys to navigate to the next match
        next_mapping = "nzzzv",

        -- Keys to navigate to the previous match
        prev_mapping = "Nzzzv",
      },
      paste = {
        enabled = true,
        default_animation = "reverse_fade",

        -- Keys to paste
        paste_mapping = "p",

        -- Keys to paste above the cursor
        Paste_mapping = "P",
      },
      undo = {
        enabled = true,

        default_animation = {
          name = "fade",

          settings = {
            from_color = "DiffDelete",

            max_duration = 500,
            min_duration = 500,
          },
        },
        undo_mapping = "u",
      },
      redo = {
        enabled = true,

        default_animation = {
          name = "fade",

          settings = {
            from_color = "DiffAdd",

            max_duration = 500,
            min_duration = 500,
          },
        },

        redo_mapping = "<c-r>",
      },
    },

    support = {
      -- require("substitute").setup({
      --     on_substitute = require("tiny-glimmer.support.substitute").substitute_cb,
      --     highlight_substituted_text = {
      --         enabled = false,
      --     },
      --})
      substitute = {
        enabled = false,

        -- Can also be a table. Refer to overwrite.search for more information
        default_animation = "fade",
      },
    },

    presets = {
      pulsar = {
        enabled = false,
        on_events = { "CursorMoved", "CmdlineEnter", "WinEnter" },
        default_animation = {
          name = "fade",

          settings = {
            max_duration = 1000,
            min_duration = 1000,

            from_color = "DiffDelete",
            to_color = "Normal",
          },
        },
      },
    },

    -- Only use if you have a transparent background
    -- It will override the highlight group background color for `to_color` in all animations
    transparency_color = nil,
    animations = {
      fade = {
        max_duration = 400,
        min_duration = 300,
        easing = "outQuad",
        chars_for_max_duration = 10,
      },
      reverse_fade = {
        max_duration = 380,
        min_duration = 300,
        easing = "outBack",
        chars_for_max_duration = 10,
      },
      bounce = {
        max_duration = 500,
        min_duration = 400,
        chars_for_max_duration = 20,
        oscillation_count = 1,
      },
      left_to_right = {
        max_duration = 350,
        min_duration = 350,
        min_progress = 0.85,
        chars_for_max_duration = 25,
        lingering_time = 50,
      },
      pulse = {
        max_duration = 600,
        min_duration = 400,
        chars_for_max_duration = 15,
        pulse_count = 2,
        intensity = 1.2,
      },

      -- You can add as many animations as you want
      custom = {
        -- You can also add as many custom options as you want
        -- Only `max_duration` and `chars_for_max_duration` is required
        max_duration = 350,
        chars_for_max_duration = 40,

        color = hl_visual_bg,

        -- Custom effect function
        -- @param self table The effect object
        -- @param progress number The progress of the animation [0, 1]
        --
        -- Should return a color and a progress value
        -- that represents how much of the animation should be drawn
        -- self.settings represents the settings of the animation that you defined above
        effect = function(self, progress)
          return self.settings.color, progress
        end,
      },
    },
    virt_text = {
      priority = 2048,
    },
  },
}
