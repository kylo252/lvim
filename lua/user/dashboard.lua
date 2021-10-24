lvim.builtin.dashboard.active = true
vim.g.dashboard_enable_session = 0
lvim.builtin.dashboard.custom_section = {
  a = { description = { "  Recently Used Files" }, command = "Telescope oldfiles" },
  b = {
    description = { "  Find File          " },
    command = "lua require('telescope.builtin').find_files({hidden = true, ignored = false})",
  },
  c = { description = { "  Plugins            " }, command = ":edit ~/.config/nvim/lua/plugins.lua" },
  s = { description = { "  Settings           " }, command = ":edit ~/.config/nvim/lua/settings.lua" },
  d = { description = { "  Find Word          " }, command = "Telescope live_grep" },
  n = { description = { "  Load Last Session  " }, command = "SessionLoad" },
  m = { description = { "  Marks              " }, command = "Telescope marks" },
}
