local M = {}

local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"
local fnameescape = vim.fn.fnameescape
local fnamemodify = vim.fn.fnamemodify

local function join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

local function is_directory(filename)
  local stat = vim.loop.fs_stat(filename)
  return stat and stat.type == "directory" or false
end

local default_session_name = function()
  -- get the cwd but strip the homeprefix and replace the path_sep with underscores
  local def_name = fnamemodify(vim.fn.getcwd(), ":~:?")
  def_name = def_name:gsub("~" .. path_sep, ""):gsub(path_sep, "__")
  return def_name
end

local defaults = {
  -- directory where session files are saved
  dir = join_paths(vim.fn.stdpath "cache", "sessions"),
  -- sessionoptions used for saving
  options = { "buffers", "curdir", "tabpages", "winsize" },
  -- default session name
  default_session_name = default_session_name,
}

local function get_session_path(name)
  name = name or defaults.default_session_name()
  return fnameescape(join_paths(defaults.dir, name .. ".vim"))
end

function M.save_session(name)
  -- readability: replace the expanded homedir
  local tmp = vim.o.sessionoptions
  vim.o.sessionoptions = table.concat(defaults.options, ",")
  vim.cmd("mks! " .. get_session_path(name))
  vim.o.sessionoptions = tmp
end

function M.get_sessions()
  if not is_directory(defaults.dir) then
    vim.fn.mkdir(defaults.dir, "p")
  end
  return vim.tbl_map(function(v)
    local basename = fnamemodify(v, ":t:r")
    return basename
  end, vim.fn.glob(defaults.dir .. "/*", false, true))
end

local function load_session_by_name(name)
  vim.validate { requested = { name, "s", true } }
  local full_path = get_session_path(name)
  vim.schedule(function()
    vim.cmd("source " .. full_path)
  end)
end

function M.load_session(name)
  name = name or ""

  if name ~= "" then
    load_session_by_name(name)
    return
  end

  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  require("telescope.builtin").find_files {
    prompt_title = "Select a session to load",
    cwd = defaults.dir,
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        load_session_by_name(entry.value)
      end)
      return true
    end,
  }
end

return M
