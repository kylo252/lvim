local M = {}

local base_collection = {
  {
    name = "DynamicGrep",
    fn = function(nargs)
      require("user.telescope.custom-finders").dynamic_grep {
        args = nargs.args,
        fargs = nargs.fargs,
      }
    end,
    opts = { nargs = "*" },
  },
  {
    name = "FuzzyGrepString",
    fn = require("user.telescope.custom-finders").fuzzy_grep_string,
    opts = { nargs = "*" },
  },
  {
    name = "FindRuntimeFiles",
    fn = require("user.telescope.custom-finders").find_runtime_files,
  },
  {
    name = "SessionLoad",
    fn = function(nargs)
      require("user.sessions").load_session(nargs.args)
    end,
    opts = {
      nargs = "?",
      complete = require("user.sessions").get_sessions,
    },
  },
  {
    name = "SessionSave",
    fn = function(nargs)
      require("user.sessions").save_session(nargs.args)
    end,
    opts = {
      nargs = "?",
      complete = require("user.sessions").get_sessions,
    },
  },
}

function M.load_commands(collection)
  local common_opts = { force = true }
  for _, cmd in pairs(collection) do
    local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
    vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts)
  end
end

function M.setup()
  M.load_commands(base_collection)
end

return M
