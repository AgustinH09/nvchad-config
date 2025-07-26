return {
  "Saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("crates").setup {
      popup = {
        border = "rounded",
        show_version_date = false,
        max_height = 30,
        min_width = 20,
        padding = 1,
        show_dependency_version = true,
        show_versions = true,
        show_targets = true,
        keys = {
          hide = { "q", "<esc>" },
          jump_rustc = "<cr>",
          jump_alt = "s",
          select = "<cr>",
          select_alt = "S",
          toggle_feature = "e",
          copy_value = "yy",
          goto_item = "gd",
          jump_rustc = "gR",
          jump_alt = "gA",
          select = "o",
          select_alt = "O",
          toggle_feature = "E",
          copy_value = "Y",
          goto_item = "gD",
        },
      },
      src = {
        insert_closing_quote = true,
        text = {
          prerelease = "   ",
          yanked = "   ",
        },
        coq = {
          enabled = false,
          name = "Crates",
        },
      },
      null_ls = {
        enabled = false,
        name = "Crates",
      },
      on_attach = function(bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>ct", require("crates").toggle, opts)
        vim.keymap.set("n", "<leader>cr", require("crates").reload, opts)
        vim.keymap.set("n", "<leader>cv", require("crates").show_versions_popup, opts)
        vim.keymap.set("n", "<leader>cf", require("crates").show_features_popup, opts)
        vim.keymap.set("n", "<leader>cd", require("crates").show_dependencies_popup, opts)
        vim.keymap.set("n", "<leader>cu", require("crates").update_crate, opts)
        vim.keymap.set("n", "<leader>ca", require("crates").update_all_crates, opts)
        vim.keymap.set("n", "<leader>cU", require("crates").upgrade_crate, opts)
        vim.keymap.set("n", "<leader>cA", require("crates").upgrade_all_crates, opts)
        vim.keymap.set("n", "<leader>cH", require("crates").open_homepage, opts)
        vim.keymap.set("n", "<leader>cR", require("crates").open_repository, opts)
        vim.keymap.set("n", "<leader>cD", require("crates").open_documentation, opts)
        vim.keymap.set("n", "<leader>cC", require("crates").open_crates_io, opts)
      end,
    }
  end,
}
