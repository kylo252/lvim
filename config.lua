-- general
lvim.log.level = "debug"
lvim.format_on_save = true

lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.diagnostics.update_in_insert = true

for module, _ in pairs(package.loaded) do
  if module:match "user" then
    package.loaded[module] = nil
  end
end

vim.list_extend(lvim.lsp.override, { "clangd" })
vim.lsp.set_log_level "info"
require("vim.lsp.log").set_format_func(vim.inspect)

require "user.keymappings"
require "user.settings"
require "user.whichkey"
require "user.dashboard"
require "user.plugins"
require "user.utils"

local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_y = { "location" }
lvim.builtin.lualine.sections.lualine_b = { components.branch, "filename" }

---------- scratch
pcall(require, "scratch")

lvim.lsp.null_ls.config = {
  -- debug = true,
  log = {
    level = "debug",
  },
}
