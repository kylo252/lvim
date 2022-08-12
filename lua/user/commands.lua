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
    name = "ZkGrep",
    fn = require("user.telescope.custom-finders").grep_notes,
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
  {
    name = "ConfigReload",
    fn = function()
      -- hot-reload user plugins
      for module, _ in pairs(package.loaded) do
        if module:match "user" then
          _G.require_clean(module)
        end
      end
    end,
  },
}

vim.list_extend(require("lvim.core.commands").defaults, base_collection)

vim.cmd [[
function! Dump(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
    new
    nnoremap <silent> <buffer> q :close<CR>
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command Dump call Dump(<q-args>)
]]

return M
