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
    { "<c-r>", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
    { "<c-f>", "  Find File", "<CMD>Telescope find_files<CR>" },
    { "<c-n>", "  New File", "<CMD>ene!<CR>" },
    { "<c-j>", "  Recent Places", "<CMD>Telescope zoxide list<CR>" },
    { "<c-t>", "  Find Word", "<CMD>Telescope live_grep<CR>" },
    {
      "SPC p",
      "  Plugins ",
      ":edit ~/.config/lvim/lua/user/plugins.lua<cr>",
    },
    {
      "SPC s",
      "  Scratch",
      "<CMD>edit " .. scratch_file .. " <CR>",
    },
    {
      "SPC R",
      "  Load Last Session",
      "<CMD>lua require('persistence').load({ last = true })<cr>",
    },
  },
}

local section = {
  header = header,
  footer = footer,
  buttons = buttons,
}

function M.setup()
  local alpha = require "alpha"
  local dashboard = require "alpha.themes.dashboard"

  dashboard.section.buttons.val = {}

  for _, entry in pairs(section.buttons.entries) do
    local button = require("alpha.themes.dashboard").button
    table.insert(dashboard.section.buttons.val, button(entry[1], entry[2], entry[3]))
  end

  dashboard.section.header.val = section.header.val
  dashboard.section.header.opts.hl = section.header.opts.hl
  -- dashboard.section.footer.val = conf.footer.val
  alpha.setup(dashboard.config)
end

return M
