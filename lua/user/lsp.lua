local M = {}

---{{{ LSP

lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.default_keybinds = true
lvim.lsp.diagnostics.update_in_insert = true
vim.lsp.set_log_level "warn"

require("vim.lsp.log").set_format_func(vim.inspect)

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd", "rust_analyzer" })

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

local path = require("null-ls.utils").path
local root_pattern = require("null-ls.utils").root_pattern
local nls_cache = require("null-ls.helpers").cache

formatters.setup {
  { command = "shfmt", extra_args = { "-i", "2", "-ci", "-bn" } },
  { command = "stylua" },
  {
    command = "markdownlint",
    filetypes = { "markdown" },
    cwd = nls_cache.by_bufnr(function(params)
      return root_pattern ".markdownlintrc"(params.bufname)
    end),
    condition = function(utils)
      return utils.root_has_file ".markdownlintrc"
    end,
  },
}

linters.setup {
  {
    command = "markdownlint",
    filetypes = { "markdown" },
    cwd = nls_cache.by_bufnr(function(params)
      return root_pattern ".markdownlintrc"(params.bufname)
    end),
    condition = function(utils)
      return utils.root_has_file ".markdownlintrc"
    end,
  },
  {
    command = "cspell",
    filetypes = { "markdown" },
    cwd = nls_cache.by_bufnr(function(params)
      return root_pattern ".cspell.json"(params.bufname)
    end),
    condition = function(utils)
      return utils.root_has_file ".cspell.json"
    end,
  },
  {
    command = "luacheck",
    cwd = nls_cache.by_bufnr(function(params)
      return root_pattern ".luacheckrc"(params.bufname)
    end),
    runtime_condition = nls_cache.by_bufnr(function(params)
      return path.exists(path.join(params.root, ".luacheckrc"))
    end),
  },
}

return M
