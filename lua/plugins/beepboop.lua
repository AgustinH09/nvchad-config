return {
  "EggbertFluffle/beepboop.nvim",
  cmd = "BeepBoop",
  opts = {
    audio_player = "paplay",
    max_sounds = 20,
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
    -- to nvim user config directory + sounds/typewriter
    sound_directory = vim.fn.stdpath "config" .. "/sounds/typewriter",
  },
}
