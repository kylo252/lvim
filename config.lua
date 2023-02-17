-- general
lvim.log.level = "info"
lvim.log.async = false
lvim.log.override_notify = false
lvim.format_on_save = {
  enabled = true,
  ---@usage pattern string pattern used for the autocommand (Default: '*')
  pattern = "*.lua",
  ---@usage timeout number timeout in ms for the format request (Default: 1000)
  timeout = 1000,
}

---{{{ builtins
lvim.colorscheme = "lunar"

lvim.builtin.comment.mappings["extra"] = true

lvim.builtin.project.datapath = get_cache_dir()
lvim.builtin.project.manual_mode = false
lvim.builtin.project.detection_methods = { "lsp", "pattern" }
lvim.builtin.project.ignore_lsp = { "copilot", "null-ls", "lua_ls" }
lvim.builtin.project.silent_chdir = true

lvim.builtin.autopairs.disable_filetype = { "TelescopePrompt", "ps1", "sh" }

lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-\\>"
lvim.builtin.terminal.direction = "horizontal"

lvim.builtin.nvimtree.setup.filters.custom = {}
lvim.builtin.indentlines.options.show_first_indent_level = false
lvim.builtin.indentlines.options.use_treesitter = false

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

reload "user.autocmds"
reload "user.commands"
reload "user.dashboard"
reload "user.keymappings"
reload "user.lsp"
reload "user.settings"
reload "user.telescope"
reload "user.treesitter"
reload "user.utils"
---}}}

---{{{ scratch
pcall(require, "scratch")

table.insert(lvim.plugins, {
  "arkav/lualine-lsp-progress",
  lazy = true,
})

table.insert(lvim.plugins, {
  "RRethy/nvim-treesitter-textsubjects",
  lazy = true,
})

table.insert(lvim.plugins, {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telescope").load_extension "harpoon"
  end,
  lazy = true,
})

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup()
      require("copilot_cmp").setup()
    end, 100)
  end,
})

---}}}
