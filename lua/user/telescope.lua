local M = {}

function M.setup_z()
  local _, builtin = pcall(require, "telescope.builtin")
  local _, themes = pcall(require, "telescope.themes")

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
          vim.cmd [[normal! A]]
        end,
      },
      ["<C-g>"] = {
        action = function(selection)
          builtin.live_grep(themes.get_ivy { cwd = selection.path })
          vim.cmd [[normal! A]]
        end,
      },
    },
  }
end

return M
