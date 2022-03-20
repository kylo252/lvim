lvim.builtin.alpha.mode = "dashboard"

local scratch_file = "~/.config/lvim/lua/scratch.lua"

lvim.builtin.alpha.dashboard.section.buttons = {
  entries = {
    { "SPC f r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
    { "SPC f f", "  Find File", "<CMD>Telescope find_files<CR>" },
    { "SPC f l", "  Find Word", "<CMD>Telescope live_grep<CR>" },
    { "SPC f j", "  Recent Places", "<CMD>Telescope zoxide list<CR>" },
    { "SPC P", "  Recent Projects", "<CMD>Telescope projects<CR>" },
    { "SPC e", "  New File", "<CMD>ene!<CR>" },
    { "SPC R", "  Load Session", "<CMD>SessionLoad<cr>" },
    {
      "SPC s",
      "  Scratch",
      "<CMD>edit " .. scratch_file .. "<CR>",
    },
  },
}
