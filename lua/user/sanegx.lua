local M = {}

function M.open()
  if vim.fn.executable "xdg-open" ~= 1 then
    vim.notify("xdg-open was not found", vim.log.levels.WARN)
    return
  end
  local uri = vim.fn.shellescape(vim.fn.expand "<cWORD>")
  vim.notify("trying to open: " .. uri, vim.log.levels.DEBUG)
  os.execute("xdg-open " .. uri)
end

return M
