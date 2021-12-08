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

vim.list_extend(lvim.lsp.override, { "clangd", "pyright" })

require "user.keymappings"
require "user.settings"
require "user.whichkey"
require "user.dashboard"
require "user.telescope"
require "user.utils"
lvim.plugins = require "user.plugins"

local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_y = { "location" }
lvim.builtin.lualine.sections.lualine_a = { "filename" }
lvim.builtin.lualine.sections.lualine_b = { components.branch }

---------- scratch
pcall(require, "scratch")
require("vim.lsp.log").set_format_func(vim.inspect)

lvim.lsp.null_ls.config = {
  -- debug = true,
  log = {
    level = "warn",
  },
}

require("nvim-lsp-installer").settings {
  log_level = vim.log.levels.WARN,
}

local scratch_plugins = {
  "pwntester/octo.nvim",
  event = "FIleReadPost",
  opt = true,
  cmd = "Octo",
  disable = true,
}

table.insert(lvim.plugins, scratch_plugins)

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { name = "gitsigns" },
  { name = "shellcheck" },
}
