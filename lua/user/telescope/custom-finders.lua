local M = {}

local custom_actions = require "user.telescope.custom-actions"

local builtin = require "telescope.builtin"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"
local config = require "telescope.config"
local make_entry = require "telescope.make_entry"
local action_state = require "telescope.actions.state"

local Path = require "plenary.path"

function M.grep_string_v2(opts)
  opts = opts or themes.get_ivy {}

  local search_string = vim.fn.execute "history search"
  local search_list = vim.split(search_string, "\n")
  local results = {}
  for i = #search_list, 3, -1 do
    local item = search_list[i]
    local _, finish = string.find(item, "%d+ +")
    if not vim.tbl_contains(results, string.sub(item, finish + 1)) then
      table.insert(results, string.sub(item, finish + 1))
    end
  end

  pickers.new(opts, {
    prompt_title = "Search",
    finder = finders.new_table(results),
    sorter = sorters.fuzzy_with_index_bias,
    attach_mappings = function(_, map)
      map("i", "<C-y>", custom_actions.import_entry)
      map("n", "<C-y>", custom_actions.import_entry)
      map("i", "<C-space>", custom_actions.import_entry)
      map("n", "<C-space>", custom_actions.import_entry)
      map("i", "<CR>", custom_actions.fuzzy_filter_results)
      map("n", "<CR>", custom_actions.fuzzy_filter_results)
      return true
    end,
  }):find()
end

function M.fuzzy_grep_string(query)
  query = query or {}
  builtin.grep_string(themes.get_ivy {
    prompt_title = "Fuzzy grep string, initial query: " .. query,
    search = query,
  })
end

function M.grep_dotfiles()
  M.live_grep_v2 {
    search_dirs = { vim.fn.stdpath "config", os.getenv "ZDOTDIR" },
    hidden = true,
  }
end

function M.find_dotfiles()
  local opts = themes.get_ivy {
    previewer = false,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 15,
      width = 0.5,
    },
    prompt = ">> ",
    prompt_title = "~ dotfiles ~",
    cwd = "~",
    find_command = { "git", "dots", "ls-files" },
  }
  require("telescope.builtin").find_files(opts)
end

function M.local_buffer_fuzzy_grep()
  local opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 15,
      width = 0.5,
    },
    prompt = ">> ",
    path_display = "hidden",
    -- ignore_filename = true,
    -- include_extension = false,
  }
  local vimgrep_arguments = {
    "rg",
    "--no-heading",
    "--hidden",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
  }

  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  local live_grepper = finders.new_job(function(prompt)
    if not prompt or prompt == "" then
      return nil
    end

    local filelist = {}

    local bufnrs = vim.tbl_filter(function(b)
      if 1 ~= vim.fn.buflisted(b) then
        return false
      end
      return true
    end, vim.api.nvim_list_bufs())
    if not next(bufnrs) then
      return
    end

    for _, bufnr in ipairs(bufnrs) do
      local file = vim.api.nvim_buf_get_name(bufnr)
      table.insert(filelist, Path:new(file):make_relative(opts.cwd))
    end
    return vim.tbl_flatten { vimgrep_arguments, "--", prompt, filelist }
  end, make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)

  pickers.new(opts, {
    prompt_title = "Live Grep",
    finder = live_grepper,
    previewer = config.values.grep_previewer(opts),
    -- TODO: It would be cool to use `--json` output for this
    -- and then we could get the highlight positions directly.
    sorter = sorters.highlighter_only(opts),
  }):find()
end

function M.find_lvim_config()
  local opts = themes.get_ivy {
    previewer = false,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 15,
      width = 0.5,
    },
    prompt = ">> ",
    prompt_title = "~ lvim config ~",
    cwd = "~/.config/lvim",
    find_command = { "git", "ls-files" },
  }
  require("telescope.builtin").find_files(opts)
end

function M.find_runtime_files(opts)
  opts = opts or themes.get_ivy {}

  local runtimepath = vim.opt.runtimepath:get()
  local runtimedirs = {}

  for _, entry in ipairs(runtimepath) do
    vim.list_extend(runtimedirs, vim.fn.globpath(entry, "", 1, 1))
  end

  pickers.new(opts, {
    prompt_title = "select a runtime directory",
    finder = finders.new_table(runtimedirs),
    sorter = sorters.get_generic_fuzzy_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local find_in_dir = function()
        local entry = action_state.get_selected_entry()
        opts.cwd = entry.value
        opts.next_picker = "find_files"
        custom_actions.run_builtin(prompt_bufnr, opts)
      end
      local grep_in_dir = function()
        local entry = action_state.get_selected_entry()
        opts.cwd = entry.value
        opts.next_picker = "live_grep"
        custom_actions.run_builtin(prompt_bufnr, opts)
      end

      map("i", "<cr>", find_in_dir)
      map("i", "<c-f>", find_in_dir)
      map("i", "<c-g>", grep_in_dir)
      return true
    end,
  }):find()
end

function M.find_files_local(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ relative files ~",
    cwd = require("telescope.utils").buffer_dir(),
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  require("telescope.builtin").find_files(opts)
end

function M.find_project_files()
  local ok = pcall(builtin.git_files)
  if not ok then
    builtin.find_files()
  end
end

function M.dynamic_grep(opts)
  opts = opts or themes.get_ivy {}
  opts.vimgrep_arguments = opts.vimgrep_arguments or vim.deepcopy(config.values.vimgrep_arguments)

  local type = string.match(opts.args, "type=(%w+)", 1)
  local glob = string.match(opts.args, "glob=(%w+)", 1)

  if type then
    opts.vimgrep_arguments[#opts.vimgrep_arguments + 1] = "--type=" .. type
  end

  if glob then
    opts.vimgrep_arguments[#opts.vimgrep_arguments + 1] = "--glob=" .. glob
  end

  builtin.live_grep(vim.tbl_deep_extend("force", {
    prompt_title = "Search",
    attach_mappings = function(prompt_bufnr, map)
      local fuzzy_filter_results = function()
        local query = action_state.get_current_line()
        if not query then
          print "no matching results"
          return
        end
        vim.fn.histadd("search", query)
        opts.search = query
        opts.prompt_title = "Filter"
        opts.prompt_prefix = "/" .. query .. " >> "
        opts.next_picker = "grep_string"
        custom_actions.run_builtin(prompt_bufnr, opts)
      end

      local dynamic_filetype = function()
        local entry = action_state.get_selected_entry()
        local onlytype = vim.fn.fnamemodify(entry.filename, ":e")
        opts.prompt_prefix = opts.prompt_prefix or "*." .. onlytype .. " >> "
        opts.prompt_title = "Scoped Results"
        vim.list_extend(opts.vimgrep_arguments, { "--type=" .. onlytype })

        opts.next_picker = "live_grep"
        custom_actions.run_builtin(prompt_bufnr, opts)
      end

      local dynamic_filetype_skip = function()
        local entry = action_state.get_selected_entry()
        local skiptype = vim.fn.fnamemodify(entry.filename, ":e")
        opts.vimgrep_arguments = vim.deepcopy(config.values.vimgrep_arguments)
        opts.prompt_prefix = opts.prompt_prefix or "!*." .. skiptype .. " >> "
        opts.prompt_title = "Scoped Results"
        vim.list_extend(opts.vimgrep_arguments, { "--type-not=" .. skiptype })

        opts.next_picker = "live_grep"
        custom_actions.run_builtin(prompt_bufnr, opts)
      end

      -- local reset_search = function()
      --   opts.next_picker = "live_grep"
      --   opts.prompt_prefix = opts.prompt_prefix or " >> "
      --   custom_actions.run_builtin(prompt_bufnr, opts)
      -- end

      map("i", "<C-space>", fuzzy_filter_results)
      map("n", "<C-space>", fuzzy_filter_results)
      map("i", "<C-f>", dynamic_filetype)
      map("n", "<C-f>", dynamic_filetype)
      map("i", "<C-g>", dynamic_filetype_skip)
      map("n", "<C-g>", dynamic_filetype_skip)
      -- map("i", "<M-r>", reset_search)
      -- map("n", "<M-r>", reset_search)
      return true
    end,
  }, opts))
end
return M
