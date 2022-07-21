local M = {}

function M.get_github_blame_url(opts)
  local gitlinker = require "gitlinker"
  local user_opts = vim.tbl_deep_extend("force", {
    print_url = false,
    remote = "origin",
  }, opts or {})
  local repo_url = gitlinker.get_repo_url(user_opts)

  local win_id = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()
  local cur_pos = vim.api.nvim_win_get_cursor(win_id)
  ---@diagnostic disable-next-line: missing-parameter
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local repo = vim.loop.cwd()
  local lnum = cur_pos[1]
  local args = {
    "log",
    "-L" .. lnum .. "," .. lnum + 1 .. ":" .. filename,
    "--pretty=%H",
    "--no-patch",
  }
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
