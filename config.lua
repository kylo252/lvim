-- general
lvim.log.level = "warn"
lvim.format_on_save = true

lvim.builtin.notify.active = true
-- lvim.log.override_notify = true

lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.diagnostics.update_in_insert = true

lvim.builtin.notify.active = true
for module, _ in pairs(package.loaded) do
  if module:match "user" then
    _G.require_clean(module)
  end
end

vim.list_extend(lvim.lsp.override, { "clangd" })

require "user.keymappings"
require "user.settings"
require "user.whichkey"
require "user.dashboard"
require "user.utils"
lvim.plugins = require "user.plugins"

local components = require "lvim.core.lualine.components"
-- lvim.builtin.lualine.sections.lualine_y = { "location" }
lvim.builtin.lualine.sections.lualine_b = { "filename", components.branch }
---------- scratch
pcall(require, "scratch")

lvim.lsp.null_ls.config = {
  -- debug = true,
  log = {
    level = "debug",
  },
}

require("nvim-lsp-installer").settings {
  log_level = vim.log.levels.DEBUG,
}

vim.tbl_deep_extend("keep", lvim.plugins, {
  { "chrisbra/Colorizer", cmd = "ColorToggle", opt = true },
})
