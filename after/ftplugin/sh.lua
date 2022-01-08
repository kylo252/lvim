local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { command = "shfmt", extra_args = { "-i", "2", "-ci", "-bn" } } }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "shellcheck" } }

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup { { name = "shellcheck" } }
