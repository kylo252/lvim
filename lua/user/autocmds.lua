local M = {}

pcall(vim.api.nvim_clear_autocmds, {
  event = "FileType",
  group = "_filetype_settings",
})

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
    "FileType",
    {
      group = "_filetype_settings",
      pattern = { "gitcommit", "markdown" },
      command = "setl fdm=indent fdl=2 spell spc= list lcs=trail:* tw=100",
    },
  },
}

return M
