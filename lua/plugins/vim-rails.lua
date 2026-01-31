return {
  "tpope/vim-rails",
  ft = { "ruby", "eruby", "haml", "slim" },
  dependencies = {
    "tpope/vim-projectionist",
    "tpope/vim-rake",
  },
  config = function()
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
}
