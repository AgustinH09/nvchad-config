return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    local function get_node_path()
      local versions = { "24.3.0", "stable" }
      for _, v in ipairs(versions) do
        local cmd = "mise where node@" .. v
        local path = vim.trim(vim.fn.system(cmd))

        if vim.v.shell_error == 0 and path ~= "" then
          local bin = path .. "/bin/node"
          if vim.fn.executable(bin) == 1 then
            return bin
          end
        end
      end
      return vim.fn.exepath "node"
    end

    require("copilot").setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      copilot_node_command = get_node_path(),
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = true,
      },
    }
  end,
}
