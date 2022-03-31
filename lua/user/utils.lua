local M = {}
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

function M.copy_help_url()
  if vim.bo.filetype ~= "help" then
    return
  end
  local last_search_query = function()
    local history_string = vim.fn.execute "history :"
    local history_list = vim.split(history_string, "\n")
    for i = #history_list, 3, -1 do
      local item = history_list[i]
      local _, finish = string.find(item, "%d+ +")
      local hist_item = string.sub(item, finish + 1)
      local query = hist_item:match "h (%S+)"
      if query then
        return query
      end
    end
    return ""
  end

  local help_url = string.format("https://neovim.io/doc/user/%s.html#%s", vim.fn.expand "%:t:r", last_search_query())
  vim.notify(help_url, vim.log.levels.INFO, { title = "help url" })
  vim.fn.setreg("+", help_url)
end

function M.get_blame_url()
  local repo_url = require("gitlinker").get_repo_url { print_url = false }

  local win_id = vim.api.nvim_get_current_win()
  local cur_pos = vim.api.nvim_win_get_cursor(win_id)
  local filename = vim.fn.expand "%"
  local repo = require("lspconfig.util").find_git_ancestor(vim.fn.expand "%:p")
  local lnum = cur_pos[2] + 1
  local args = { "log", "-L" .. lnum .. "," .. lnum + 1 .. ":" .. filename, "--pretty=%H", "--no-patch" }
  local job = require("plenary.job"):new { command = "git", args = args, cwd = repo }
  local commit_url
  job:after_success(function(this_job)
    local commit_sha = this_job:result()[1]
    commit_url = repo_url .. "/commit/" .. commit_sha
    vim.schedule(function()
      vim.notify(commit_url, vim.log.levels.INFO, { title = "commit url" })
      vim.fn.setreg("+", commit_url)
    end)
  end)
  job:start()
end

function M.on_dir_changed()
  local entry = vim.loop.cwd()
  local Job = require "plenary.job"
  local job = Job:new {
    command = "zoxide",
    args = { "add", entry },
  }
  job:start()
end

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end

function _G.log_entry(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  local Log = require "lvim.core.log"
  Log:info(table.concat(objects, ", "))
  return ...
end

function _G.require_clean(m)
  package.loaded[m] = nil
  _G[m] = nil
  local _, module = pcall(require, m)
  return module
end

return M
