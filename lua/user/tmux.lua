local M = {}

function M.set_tmux_win_title(pattern)
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
  if not buftype or buftype == "nofile" or buftype == "quickfix" or buftype == "help" then
    return
  end
  local title = vim.fn.expand(pattern)
  vim.opt.titlestring = title
  local Job = require "plenary.job"
  Job
    :new({
      command = "tmux",
      args = { "rename-window", title },
    })
    :start()
end

-- lvim.autocommands.custom_groups = {
--   { "BufEnter", "*", "lua require('user.tmux').set_tmux_win_title('%:t')" },
-- }

function M.setup()
  require("tmux").setup {
    navigation = {
      -- cycles to opposite pane while navigating into the border
      cycle_navigation = true,

      -- enables default keybindings (C-hjkl) for normal mode
      enable_default_keybindings = true,

      -- prevents unzoom tmux when navigating beyond vim border
      persist_zoom = true,
    },
    copy_sync = {
      -- enables copy sync and overwrites all register actions to
      -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
      enable = false,
    },
    resize = {
      -- enables default keybindings (A-hjkl) for normal mode
      enable_default_keybindings = true,
    },
  }
end

return M
