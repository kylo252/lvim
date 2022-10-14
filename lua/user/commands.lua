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
    fn = function(opts)
      require("user.sessions").load_session(opts.args)
    end,
    opts = {
      nargs = 1,
      complete = require("user.sessions").get_sessions,
    },
  },
  {
    name = "SessionSave",
    fn = function(opts)
      require("user.sessions").save_session(opts.args)
    end,
    opts = {
      nargs = 1,
      complete = require("user.sessions").get_sessions,
    },
  },
  {
    name = "NullLsToggle",
    fn = function(opts)
      require("null-ls.sources").toggle(opts.args)
    end,
    opts = {
      nargs = 1,
      complete = function()
        local s = require "null-ls.sources"
        local available_sources = s.get_available()
        local list = {}
        for _, source in ipairs(available_sources) do
          list[#list + 1] = source.name
        end
        return list
      end,
    },
  },
}

require("lvim.core.commands").load(base_collection)

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
