-- general
lvim.log.level = "info"
lvim.format_on_save = true

lvim.builtin.terminal.active = true
lvim.builtin.project.datapath = vim.fn.stdpath("cache") .. "/lvim"

lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.nvimtree.disable_window_picker = 1

lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.diagnostics.update_in_insert = true

require("user.keymappings")
require("user.settings")
require("user.whichkey")
require("user.dashboard")
require("user.plugins")

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_y = { "location" }
lvim.builtin.lualine.sections.lualine_b = { components.branch, "filename" }

---------- scratch
pcall(require, "scratch")

function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
	return ...
end
