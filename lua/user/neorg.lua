local M = {}

function M.setup()
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

  -- These two are optional and provide syntax highlighting
  -- for Neorg tables and the @document.meta tag
  parser_configs.norg_meta = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
      files = { "src/parser.c" },
      branch = "main",
    },
  }

  parser_configs.norg_table = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
      files = { "src/parser.c" },
      branch = "main",
    },
  }

  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.concealer"] = {
        config = { -- Note that this table is optional and doesn't need to be provided
          -- Configuration here
        },
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            notes = "~/notes",
          },
        },
      },
    },
  }
end

return M
