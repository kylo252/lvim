lvim.builtin.dashboard.active = false

local M = {}

local scratch_file = "~/.config/lvim/lua/scratch.lua"

local header = {
  type = "text",
  val = lvim.builtin.dashboard.custom_header,
  opts = {
    position = "center",
    hl = "String",
  },
}

local footer = {
  type = "text",
  -- val = {},
  opts = {
    position = "center",
    hl = "Number",
  },
}

local buttons = {
  entries = {
    { keybind = "SPC r", description = "  Recently Used Files", command = "<CMD>Telescope oldfiles<CR>" },
    { keybind = "SPC f", description = "  Find File", command = "<CMD>Telescope find_files<CR>" },
    { keybind = "SPC n", description = "  New File", command = "<CMD>ene!<CR>" },
    { keybind = "SPC j", description = "  Recent Places", command = "<CMD>Telescope zoxide list<CR>" },
    { keybind = "SPC t", description = "  Find Word", command = "<CMD>Telescope live_grep<CR>" },
    {
      keybind = "SPC p",
      description = "  Plugins ",
      command = ":edit ~/.config/lvim/lua/user/plugins.lua<cr>",
    },
    {
      keybind = "SPC s",
      description = "  Scratch",
      command = "<CMD>edit " .. scratch_file .. " <CR>",
    },
    {
      keybind = "SPC R",
      description = "  Load Last Session",
      command = "<CMD>lua require('persistence').load({ last = true })<cr>",
    },
  },
}

local conf = {
  header = header,
  footer = footer,
  buttons = buttons,
}

function M.setup()
  local alpha = require "alpha"
  local dashboard = require "alpha.themes.dashboard"

  dashboard.section.buttons.val = {}

  for _, entry in pairs(conf.buttons.entries) do
    local button = require("alpha.themes.dashboard").button
    table.insert(dashboard.section.buttons.val, button(entry.keybind, entry.description, entry.command))
  end

  dashboard.section.header.val = conf.header.val
  dashboard.section.header.opts.hl = conf.header.opts.hl
  -- dashboard.section.footer.val = conf.footer.val
  alpha.setup(dashboard.opts)
end

return M
