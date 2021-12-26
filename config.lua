-- general
lvim.log.level = "warn"
-- lvim.log.override_notify = true
lvim.format_on_save = true

---{{{ builtins
lvim.builtin.notify.active = true
lvim.builtin.bufferline.active = false

lvim.builtin.project.datapath = vim.fn.stdpath "cache" .. "/lvim"
lvim.builtin.project.detection_methods = { "lsp", "pattern" }

lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"

lvim.builtin.nvimtree.disable_window_picker = 1

local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_y = { "location" }
lvim.builtin.lualine.sections.lualine_a = { "filename" }
lvim.builtin.lualine.sections.lualine_b = { components.branch }
---}}}

---{{{ LSP
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.diagnostics.update_in_insert = true

require("vim.lsp.log").set_format_func(vim.inspect)

lvim.lsp.null_ls.setup = {
  -- debug = true,
  log = {
    level = "warn",
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { name = "gitsigns" },
}

require("nvim-lsp-installer").settings {
  log_level = vim.log.levels.WARN,
}

lvim.lsp.on_attach_callback = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

vim.list_extend(lvim.lsp.override, { "clangd", "pyright", "sumneko_lua" })
---}}}

---{{{ plugins
-- hot-reload user plugins
for module, _ in pairs(package.loaded) do
  if module:match "user" then
    _G.require_clean(module)
  end
end

require "user.keymappings"
require "user.settings"
require "user.whichkey"
require "user.dashboard"
require "user.telescope"
require "user.utils"

lvim.plugins = require "user.plugins"
---}}}

---{{{ scratch
pcall(require, "scratch")
local scratch_plugins = {
  "pwntester/octo.nvim",
  event = "FIleReadPost",
  opt = true,
  cmd = "Octo",
  disable = true,
}

table.insert(lvim.plugins, scratch_plugins)
---}}}
