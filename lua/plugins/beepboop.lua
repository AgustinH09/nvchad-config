local profiles = {
  typewriter = {
    sound_directory = vim.fn.stdpath "config" .. "/sounds/typewriter",
    sound_map = {
      {
        auto_command = "InsertCharPre",
        key_map = { mode = "i", key_chord = "<BS>" },
        sounds = {
          "sounds_typewriter1.wav",
          "sounds_typewriter2.wav",
          "sounds_typewriter3.wav",
          "sounds_typewriter4.wav",
          "sounds_typewriter5.wav",
        },
      },
    },
  },
  minecraft = {
    sound_directory = vim.fn.stdpath "config" .. "/sounds/minecraft",
    sound_map = {
      { trigger_name = "runprogram", key_map = { mode = "i", key_chord = "<BS>" }, sound = "pop.wav" },
      { auto_command = "VimEnter", sound = "chestopen.wav" },
      { trigger_name = "chestclosed", auto_command = "VimLeavePre", sound = "chestclosed.wav" },
      { auto_command = "InsertCharPre", sounds = { "stone1.wav", "stone2.wav", "stone3.wav", "stone4.wav" } },
      { auto_command = "TextYankPost", sounds = { "hit1.wav", "hit2.wav", "hit3.wav" } },
      { auto_command = "BufWrite", sounds = { "open_flip1.wav", "open_flip2.wav", "open_flip3.wav" } },
    },
  },
}

return {
  "EggbertFluffle/beepboop.nvim",
  name = "beepboop.nvim",
  lazy = true,
  opts = function()
    local profile_name = vim.g.beepboop_profile or "typewriter"
    local profile_config = profiles[profile_name] or profiles.typewriter

    return {
      audio_player = "paplay",
      max_sounds = 20,
      sound_map = profile_config.sound_map,
      sound_directory = profile_config.sound_directory,
    }
  end,
}
