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

lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<C-\\>"
lvim.builtin.terminal.direction = "horizontal"

local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_y = { "location" }
lvim.builtin.lualine.sections.lualine_a = { { "filename", path = 1 } }
lvim.builtin.lualine.sections.lualine_b = { components.branch }
lvim.builtin.lualine.sections.lualine_c = {
  components.diff,
  {
    "lsp_progress",
    colors = { use = true },
  },
}
---}}}

---{{{ LSP
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.diagnostics.update_in_insert = true

vim.lsp.set_log_level "warn"
require("vim.lsp.log").set_format_func(vim.inspect)

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd", "pyright", "rust_analyzer" })

lvim.lsp.on_attach_callback = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

require("nvim-lsp-installer").settings {
  log_level = vim.log.levels.WARN,
}

lvim.lsp.null_ls.setup = {
  log = {
    level = "warn",
  },
}

local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"
local code_actions = require "lvim.lsp.null-ls.code_actions"

formatters.setup {
  { command = "shfmt", extra_args = { "-i", "2", "-ci", "-bn" } },
  { command = "stylua" },
  -- { command = "prettier" },
}

linters.setup {
  { command = "shellcheck" },
  {
    command = "luacheck",
    cwd = function(params) -- force luacheck to find its '.luacheckrc' file
      local u = require "null-ls.utils"
      return u.root_pattern ".luacheckrc"(params.bufname)
    end,
  },
}

code_actions.setup { { name = "shellcheck" } }
---}}}

---{{{ plugins
-- hot-reload user plugins
for module, _ in pairs(package.loaded) do
  if module:match "user" then
    _G.require_clean(module)
  end
end

lvim.autocommands = {
  {
    "DirChanged",
    {
      desc = "add cwd to zoxide",
      group = "_general_settings",
      pattern = "*",
      callback = require("user.utils").on_dir_changed,
    },
  },
}

require "user.keymappings"
require "user.settings"
require "user.whichkey"
require "user.dashboard"
require "user.telescope"
require "user.utils"
require("user.commands").setup()
require "user.treesitter"

lvim.plugins = require "user.plugins"
---}}}

---{{{ scratch
pcall(require, "scratch")

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

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
---}}}
