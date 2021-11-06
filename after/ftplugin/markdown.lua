require("lvim.lsp.manager").setup "ltex"
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { exe = "prettier", filetypes = { "markdown" } } }
vim.cmd [[
  setl list
  setl listchars=trail:*
]]
