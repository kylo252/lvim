local before_init = function(_, config)
  if vim.env.VIRTUAL_ENV then
    local path_util = require("lspconfig.util").path
    local python_bin = path_util.join(vim.env.VIRTUAL_ENV, "bin", "python3")
    config.settings.python.pythonPath = python_bin
  end
end

local opts = {
  before_init = before_init,
  settings = {
    pyright = {},
  },
}

require("lvim.lsp.manager").setup("pyright", opts)
