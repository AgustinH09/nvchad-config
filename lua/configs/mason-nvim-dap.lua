local opts = {
  automatic_installation = true,
  handlers = {
    function(config)
      -- all sources with no handler get passed here
      -- Keep original functionality
      require("mason-nvim-dap").default_setup(config)
    end,
    -- Custom handlers for specific debuggers can be added here
  },

  ensure_installed = {
    -- JavaScript/TypeScript
    "js-debug-adapter",
    -- Go (delve)
    "delve",
    -- Rust
    "codelldb",
    -- Ruby
    "ruby-debug-adapter",
  },
}

return opts
