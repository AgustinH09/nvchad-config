return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    { 'nvim-telescope/telescope.nvim' },
    { 'ibhagwan/fzf-lua' },
  },
  config = function ()
    require('neoclip').setup({
      history = 500,
      enable_persistent_history = true,
      continous_sync = false,
      --db_path = "/databases/neoclip.sqlite3",
      preview = true,

    })
  end,
}

