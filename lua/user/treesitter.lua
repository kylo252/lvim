-- avoid problems with old `gcc` on RHEL7
local M = {}
function M.setup()
  -- require("nvim-treesitter.install").compilers = { "clang", "gcc" }

  require("nvim-treesitter.configs").setup {
    ensure_installed = { "bash", "lua" },
    highlight = { enable = true },
    -- indent = {enable = true, disable = {"python", "html", "javascript"}},
    indent = { enable = true },
    autotag = { enable = true },
    rainbow = { enable = false },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ar"] = "@parameter.inner", -- "ap" is already used
          ["ir"] = "@parameter.outer", -- "ip" is already used
          ["."] = "textsubjects-smart",
          [";"] = "textsubjects-big",
          --[[ -- Or you can define your own textobjects like this
				["iF"] = {
					python = "(function_definition) @function",
					cpp = "(function_definition) @function",
					c = "(function_definition) @function",
					java = "(method_declaration) @function",
				}, ]]
        },
      },
    },
  }
end
return M
