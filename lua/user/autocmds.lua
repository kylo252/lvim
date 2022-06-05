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
}

return M
