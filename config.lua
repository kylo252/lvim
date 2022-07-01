-- general
lvim.log.level = "info"
lvim.log.override_notify = false

lvim.format_on_save = {
  ---@usage pattern string pattern used for the autocommand (Default: '*')
  pattern = "*.lua",
  ---@usage timeout number timeout in ms for the format request (Default: 1000)
  timeout = 1000,
}

---{{{ builtins
lvim.builtin.notify.active = true

lvim.builtin.comment.mappings["extra"] = true
lvim.builtin.comment.mappings["extended"] = true

lvim.builtin.project.datapath = get_cache_dir()
lvim.builtin.project.manual_mode = false
lvim.builtin.project.detection_methods = { "lsp", "pattern" }
lvim.builtin.project.ignore_lsp = { "null-ls" }
lvim.builtin.project.silent_chdir = true

lvim.builtin.autopairs.disable_filetype = { "TelescopePrompt", "ps1", "sh" }

lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-\\>"
lvim.builtin.terminal.direction = "horizontal"

local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_y = { "location" }
lvim.builtin.lualine.sections.lualine_a = { components.branch }
lvim.builtin.lualine.sections.lualine_b = { { "filename", path = 1 } }
lvim.builtin.lualine.sections.lualine_c = {
  components.diff,
  {
    "lsp_progress",
    colors = { use = true },
  },
}
---}}}

---{{{ plugins
lvim.plugins = require_clean "user.plugins"

require_clean "user.commands"
require_clean "user.dashboard"
require_clean "user.keymappings"
require_clean "user.lsp"
require_clean "user.settings"
require_clean "user.telescope"
require_clean "user.treesitter"
require_clean "user.utils"
---}}}

---{{{ scratch
pcall(require, "scratch")

table.insert(lvim.plugins, {
  "arkav/lualine-lsp-progress",
  opt = false,
  disable = false,
})

table.insert(lvim.plugins, {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({ "css", "scss", "html", "javascript" }, {})
  end,
})

table.insert(lvim.plugins, {
  "RRethy/nvim-treesitter-textsubjects",
})

table.insert(lvim.plugins, {
  "ThePrimeagen/harpoon",
  requires = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telescope").load_extension "harpoon"
  end,
})

table.insert(lvim.plugins, {
  "anuvyklack/pretty-fold.nvim",
  config = function()
    require("pretty-fold").setup()
  end,
})
---}}}
