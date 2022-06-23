local M = {}

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
  {
    command = "markdownlint",
    filetypes = { "markdown" },
    cwd = function(params)
      local u = require "null-ls.utils"
      return u.root_pattern ".markdownlintrc"(params.bufname)
    end,
  },
}

linters.setup {
  { command = "shellcheck" },
  {
    command = "markdownlint",
    filetypes = { "markdown" },
    cwd = function(params)
      local u = require "null-ls.utils"
      return u.root_pattern ".markdownlintrc"(params.bufname)
    end,
  },
  {
    command = "cspell",
    filetypes = { "markdown" },
    condition = function(utils)
      return utils.root_has_file { ".cspell.json" }
    end,
  },
  {
    command = "luacheck",
    cwd = function(params) -- force luacheck to find its config file
      local u = require "null-ls.utils"
      return u.root_pattern ".luacheckrc"(params.bufname)
    end,
  },
}

code_actions.setup { { name = "shellcheck" } }

return M
