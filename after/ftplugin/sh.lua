local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { exe = "shfmt", args = { "-i", "2", "-ci", "-bn" } } }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { exe = "shellcheck" } }

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup { { name = "shellcheck" } }
