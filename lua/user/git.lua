
local M = {}
function M.get_blame_url()
  local repo_url = require("gitlinker").get_repo_url { print_url = false }

  local win_id = vim.api.nvim_get_current_win()
  local cur_pos = vim.api.nvim_win_get_cursor(win_id)
  local filename = vim.fn.expand "%"
  local repo = require("lspconfig.util").find_git_ancestor(vim.fn.expand "%:p")
  local lnum = cur_pos[1] + 1
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

return M
