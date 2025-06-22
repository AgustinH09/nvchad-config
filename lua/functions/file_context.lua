local function file_context()
  local file_path = vim.fn.expand "%"

  if file_path == "" then
    vim.notify("Cannot copy context: No file name.", vim.log.levels.WARN)
    return
  end

  local file_type = vim.bo.filetype
  local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local content_for_llm = {
    "-- FILE: " .. file_path .. " --",
    "```" .. file_type,
  }

  for _, line in ipairs(all_lines) do
    table.insert(content_for_llm, line)
  end

  table.insert(content_for_llm, "```")
  content_for_llm = table.concat(content_for_llm, "\n")

  vim.fn.setreg("+", content_for_llm)
  vim.notify("Copied file with context to clipboard!", vim.log.levels.INFO)
  return content_for_llm
end

vim.api.nvim_create_user_command("FileContext", file_context, {
  desc = "Copy file with context for LLM",
  force = true,
})

return file_context
