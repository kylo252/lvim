local before_init = function(_, config)
  if vim.env.VIRTUAL_ENV then
    local python_bin = require("lspconfig.util").path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
    config.settings.python.pythonPath = python_bin
  end
end

local pylsp_opts = {
  -- autostart = false,
  before_init = before_init,
  settings = {
    pylsp = {
      plugins = {
        flake8 = {
          enabled = true,
        },
        pyflakes = {
          enabled = false,
        },
        pycodestyle = {
          enabled = false,
        },
        pylint = {
          enabled = false,
        },
        isort = {
          enabled = true,
        },
        black = {
          enabled = true,
        },
      },
    },
  },
}

require("lvim.lsp.manager").setup("pylsp", pylsp_opts)
