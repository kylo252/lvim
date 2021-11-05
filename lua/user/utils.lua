local M = {}

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end

function _G.log_q(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  local log = require("plenary.log").new { plugin = "quick", use_console = "sync", level = "debug", info_level = 5 }
  return log.info(unpack(objects))
end

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

  local url = string.format("https://neovim.io/doc/user/%s.html#%s", vim.fn.expand "%:t:r", last_search_query())
  vim.api.nvim_command("let @+ = '" .. url .. "'")
  print("copied: " .. url)
end

function _G.require_clean(m)
  package.loaded[m] = nil
  _G[m] = nil
  local _, module = pcall(require, m)
  return module
end

return M
