local M = {}

local _, actions = pcall(require, "telescope.actions")
local _, action_state = pcall(require, "telescope.actions.state")
local _, builtin = pcall(require, "telescope.builtin")
local _, themes = pcall(require, "telescope.themes")

M.import_entry = function(prompt_bufnr)
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

M.run_telescope_command = function(request)
  local command
  if request == "files" then
    command = builtin.find_files
  elseif request == "grep" then
    command = builtin.live_grep
  end
  return function(selection)
    command { cwd = selection.path }
  end
end

M.fuzzy_filter_results = function()
  local query = action_state.get_current_line()

  if not query then
    print "no matching results"
    return
  end

  vim.fn.histadd("search", query)
  -- print(vim.inspect(entry))
  builtin.grep_string {
    search = query,
    prompt_title = "Filter",
    prompt_prefix = "/" .. query .. " >> ",
    preview_title = "Preview",
    layout_config = {
      prompt_position = "bottom",
    },
  }
  vim.cmd [[normal! A]]
end

M.find_in_dir = function(_, opts)
  local entry = action_state.get_selected_entry()
  opts = opts or themes.get_ivy()
  opts.cwd = entry.value
  builtin.find_files(opts)
  vim.cmd [[normal! A]]
end

M.grep_in_dir = function(_, opts)
  local entry = action_state.get_selected_entry()
  opts = opts or themes.get_ivy()
  opts.cwd = entry.value
  builtin.live_grep(opts)
  vim.cmd [[normal! A]]
end

return M
