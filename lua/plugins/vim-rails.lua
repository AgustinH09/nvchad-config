return {
  "tpope/vim-rails",
  ft = { "ruby", "eruby", "haml", "slim" },
  dependencies = {
    "tpope/vim-projectionist",
    "tpope/vim-rake",
  },
  config = function()
    -- Enable :A command for alternate files
    vim.g.rails_projections = {
      ["app/models/*.rb"] = {
        alternate = "spec/models/{}_spec.rb",
        type = "model",
      },
      ["app/controllers/*.rb"] = {
        alternate = "spec/controllers/{}_spec.rb",
        type = "controller",
      },
      ["app/views/*"] = {
        alternate = "spec/views/{}_spec.rb",
        type = "view",
      },
      ["lib/*.rb"] = {
        alternate = "spec/lib/{}_spec.rb",
        type = "lib",
      },
      ["spec/*_spec.rb"] = {
        alternate = "app/{}.rb",
        type = "spec",
      },
    }
  end,
  keys = {
    -- Navigation
    { "<leader>rc", ":Econtroller ", desc = "Go to controller", ft = { "ruby", "eruby" } },
    { "<leader>rm", ":Emodel ", desc = "Go to model", ft = { "ruby", "eruby" } },
    { "<leader>rv", ":Eview ", desc = "Go to view", ft = { "ruby", "eruby" } },
    { "<leader>rh", ":Ehelper ", desc = "Go to helper", ft = { "ruby", "eruby" } },
    { "<leader>rM", ":Emigration ", desc = "Go to migration", ft = { "ruby", "eruby" } },
    { "<leader>rs", ":Espec ", desc = "Go to spec", ft = { "ruby", "eruby" } },
    { "<leader>rS", ":Eschema<cr>", desc = "Go to schema", ft = { "ruby", "eruby" } },
    { "<leader>rR", ":Einitializer ", desc = "Go to initializer", ft = { "ruby", "eruby" } },

    -- Alternate file
    { "<leader>ra", "<cmd>A<cr>", desc = "Alternate file", ft = { "ruby", "eruby" } },
    { "<leader>rA", "<cmd>AV<cr>", desc = "Alternate file (vertical)", ft = { "ruby", "eruby" } },

    -- Rails commands
    { "<leader>rr", ":Rails ", desc = "Rails command", ft = { "ruby", "eruby" } },
    { "<leader>rg", ":Generate ", desc = "Rails generate", ft = { "ruby", "eruby" } },
    { "<leader>rd", ":Destroy ", desc = "Rails destroy", ft = { "ruby", "eruby" } },

    -- Database
    { "<leader>rdb", "<cmd>Rails db:migrate<cr>", desc = "Run migrations", ft = { "ruby", "eruby" } },
    { "<leader>rdr", "<cmd>Rails db:rollback<cr>", desc = "Rollback migration", ft = { "ruby", "eruby" } },
    { "<leader>rds", "<cmd>Rails db:seed<cr>", desc = "Seed database", ft = { "ruby", "eruby" } },

    -- Testing
    { "<leader>rT", "<cmd>Rails test %<cr>", desc = "Test current file", ft = { "ruby", "eruby" } },

    -- Server
    { "<leader>rss", "<cmd>Rails server<cr>", desc = "Start server", ft = { "ruby", "eruby" } },
    { "<leader>rsc", "<cmd>Rails console<cr>", desc = "Start console", ft = { "ruby", "eruby" } },
  },
}
