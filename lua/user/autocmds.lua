local M = {}

-- pcall(vim.api.nvim_clear_autocmds, {
--   event = "FileType",
--   group = "_filetype_settings",
-- })

lvim.autocommands = {
  {
    "DirChanged",
    {
      desc = "add cwd to zoxide",
      group = "_general_settings",
      pattern = "*",
      callback = require("user.utils").on_dir_changed,
    },
  },
  {
    "DirChanged",
    {
      group = "_general_settings",
      pattern = "*",
      desc = "set osc7 so that tmux can see it",
      command = [[call chansend(v:stderr, printf("\033]7;%s\033", v:event.cwd))]],
    },
  },
  {
    "FileType",
    {
      group = "_filetype_settings",
      pattern = { "gitcommit", "markdown" },
      command = "setl fdm=indent fdl=2 spell spc= list lcs=trail:* tw=100",
    },
  },
}

return M
