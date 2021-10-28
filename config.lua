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

require "user.keymappings"
require "user.settings"
require "user.whichkey"
require "user.dashboard"
require "user.plugins"

local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_y = { "location" }
lvim.builtin.lualine.sections.lualine_b = { components.branch, "filename" }

---------- scratch
pcall(require, "scratch")

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end
