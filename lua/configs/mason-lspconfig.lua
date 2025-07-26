local lspconfig = require "lspconfig"

-- which of your lspconfig servers to skip installing
local ignore_install = {}

local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Setup mason-lspconfig
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "biome",
    "eslint",
    "gopls",
    "ruby_lsp",
    "rust_analyzer",
    "pyright",
    "hyprls",
    "marksman",
    -- "markdown-oxide", -- Disabled to avoid conflicts with marksman
    "harper_ls",
  },
  automatic_installation = {
    exclude = ignore_install,
  },
}

-- Setup handlers
-- require("mason-lspconfig").setup_handlers {
--   -- Default handler for all servers
--   function(server_name)
--     if not vim.tbl_contains(ignore_install, server_name) then
--       lspconfig[server_name].setup {
--         on_attach = on_attach,
--         capabilities = capabilities,
--       }
--     end
--   end,
--
--   -- Custom handlers for specific servers can be added here
--   -- ["rust_analyzer"] = function()
--   --   -- Custom rust_analyzer setup handled by rustaceanvim
--   -- end,
-- }

-- Diagnostic command for Mason issues
vim.api.nvim_create_user_command("MasonDiagnostics", function()
  print "=== Mason Diagnostics ==="

  -- Check if Mason is loaded
  local mason_ok, mason = pcall(require, "mason")
  if mason_ok then
    print "Mason: Loaded ✓"

    -- Check registry
    local registry_ok, registry = pcall(require, "mason-registry")
    if registry_ok then
      print "Mason Registry: Available ✓"

      -- Try to get installed packages
      local ok, installed = pcall(registry.get_installed_packages)
      if ok then
        print("Installed packages: " .. #installed)
      else
        print "Failed to get installed packages"
      end
    else
      print "Mason Registry: Not available ✗"
    end
  else
    print "Mason: Not loaded ✗"
  end

  -- Check mason-lspconfig
  local mason_lsp_ok, _ = pcall(require, "mason-lspconfig")
  if mason_lsp_ok then
    print "mason-lspconfig: Loaded ✓"
  else
    print "mason-lspconfig: Not loaded ✗"
  end

  -- Check network connectivity (simple test)
  vim.fn.jobstart({ "curl", "-s", "-o", "/dev/null", "-w", "%{http_code}", "https://api.github.com" }, {
    on_exit = function(_, exit_code, _)
      if exit_code == 0 then
        print "GitHub API: Reachable ✓"
      else
        print "GitHub API: Not reachable ✗"
      end
    end,
  })
end, { desc = "Show Mason diagnostics" })
