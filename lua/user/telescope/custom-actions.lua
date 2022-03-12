local M = {}

M.import_entry = function(prompt_bufnr)
  local _, actions = pcall(require, "telescope.actions")
  local _, action_state = pcall(require, "telescope.actions.state")
  local current_picker = actions.get_current_picker(prompt_bufnr)
  local entry = action_state.get_selected_entry()

  if entry == false then
    return
  end

  current_picker:reset_prompt()
  if entry ~= nil then
    current_picker:set_prompt(entry.value)
  end
end

M.tmux_start_project = function()
  local _, action_state = pcall(require, "telescope.actions.state")
  local query = action_state.get_selected_entry()
  if query == false then
    return
  end
  local project_dir = query.path
  local project_name = string.match(project_dir, "/(%w+)$")
  local Job = require "plenary.job"
  -- local tmux_cmd = {
  --   command = "tmux",
  --   args = {"neww", "-c", project_dir, "-n", project_name, "'nvim'" },
  -- }
  local tmux_cmd = {
    command = "tmuxp",
    args = { "load", "project", "PROJECT_DIR=" .. project_dir, "PROJECT_NAME=" .. project_name },
  }
  Job:new(tmux_cmd):start()
end

M.run_builtin = function(prompt_bufnr, opts)
  local _, actions = pcall(require, "telescope.actions")
  -- make sure the options are cleanly separated
  local picker_opts = vim.deepcopy(opts)

  picker_opts.next_picker = nil
  picker_opts.entry_cb = nil

  if opts.entry_cb and type(opts.entry_cb) == "function" then
    picker_opts = vim.tbl_deep_extend("force", picker_opts, opts.entry_cb(prompt_bufnr, opts))
  end

  actions._close(prompt_bufnr, true)

  -- until https://github.com/nvim-telescope/telescope.nvim/pull/1600
  vim.schedule(function()
    vim.cmd [[startinsert!]]
  end)

  if string.match(opts.next_picker, " : ") then
    -- Call appropriate function from extensions
    local split_string = vim.split(opts.next_picker, " : ")
    local ext = split_string[1]
    local func = split_string[2]
    require("telescope").extensions[ext][func](picker_opts)
  else
    -- Call appropriate telescope builtin
    require("telescope.builtin")[opts.next_picker](picker_opts)
  end
end

return M
