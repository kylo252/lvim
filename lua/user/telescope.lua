local M = {}

local _, actions = pcall(require, "telescope.actions")
local _, themes = pcall(require, "telescope.themes")

lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-c>"] = actions.close,
    ["<C-j>"] = actions.cycle_history_next,
    ["<C-k>"] = actions.cycle_history_prev,
    ["<S-Up>"] = actions.cycle_previewers_prev,
    ["<S-Down>"] = actions.cycle_previewers_next,
    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
    ["<CR>"] = actions.select_default + actions.center,
    -- ["<C-i>"] = my_cool_custom_action,
  },
  n = {
    ["<C-c>"] = actions.close,
    ["<S-Up>"] = actions.cycle_previewers_prev,
    ["<S-Down>"] = actions.cycle_previewers_next,
    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
    -- ["<C-Space>"] = custom_actions.fuzzy_filter_results,
    -- ["<C-i>"] = my_cool_custom_action,
  },
}

local ivy = {
  theme = "ivy",
  sorting_strategy = "ascending",
  layout_strategy = "bottom_pane",
  layout_config = {
    center = {
      preview_cutoff = 70,
    },
    cursor = {
      preview_cutoff = 70,
    },
    horizontal = {
      preview_cutoff = 120,
      prompt_position = "bottom",
    },
    vertical = {
      preview_cutoff = 70,
    },
    height = 25,
  },
  border = true,
  borderchars = {
    prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
    results = { " " },
    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  },
}

local defaults = lvim.builtin.telescope.defaults
lvim.builtin.telescope.defaults = vim.tbl_deep_extend("force", defaults, ivy)

function M.setup_z()
  local _, builtin = pcall(require, "telescope.builtin")

  require("telescope._extensions.zoxide.config").setup {
    previewer = false,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 15,
      width = 0.5,
    },
    prompt = ">> ",
    prompt_title = "~ Zoxide ~",
    mappings = {
      ["<C-f>"] = {
        action = function(selection)
          builtin.find_files(themes.get_ivy { cwd = selection.path })
        end,
      },
      ["<C-g>"] = {
        action = function(selection)
          builtin.live_grep(themes.get_ivy { cwd = selection.path })
        end,
      },
    },
  }
end

return M
