local M = {}

function M.load_commands(collection)
  local common_opts = { bang = true, force = true }
  for _, cmd in pairs(collection) do
    vim.api.nvim_create_user_command(cmd.name, cmd.fn, cmd.opts or common_opts)
  end
end

local commands = {
  {
    name = "DynamicGrep",
    fn = function(nargs)
      require("user.telescope.custom-finders").dynamic_grep { args = nargs.args }
    end,
    opts = { bang = true, nargs = "*", force = true },
  },
  { name = "FindRuntimeFiles", fn = require("user.telescope.custom-finders").find_runtime_files },
  {
    name = "FuzzyGrepString",
    fn = require("user.telescope.custom-finders").fuzzy_grep_string,
    opts = { bang = true, nargs = "*", force = true },
  },
  {
    name = "SessionLoad",
    fn = function(nargs)
      require("user.sessions").load_session(nargs.args)
    end,
    opts = {
      bang = true,
      nargs = "?",
      complete = require("user.sessions").get_sessions,
      force = true,
    },
  },
  {
    name = "SessionSave",
    fn = function(nargs)
      require("user.sessions").save_session(nargs.args)
    end,
    opts = {
      bang = true,
      nargs = "?",
      complete = require("user.sessions").get_sessions,
      force = true,
    },
  },
}

M.load_commands(commands)

return M
