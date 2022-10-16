-- Set a formatter.
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
}

-- Set a linter.
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
}

local dap_python_setup = function()
  local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
  local dap_py = require "dap-python"
  dap_py.setup(mason_path .. "packages/debugpy/venv/bin/python")

  -- Supported test frameworks are unittest, pytest and django. By default it
  -- tries to detect the runner by probing for pytest.ini and manage.py, if
  -- neither are present it defaults to unittest.
  dap_py.test_runner = "pytest"

  local map = function(lhs, rhs, desc)
    if desc then
      desc = desc
    end

    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
  end
  map("<leader>dTc", dap_py.test_class, "Test Class")
  map("<leader>dTm", dap_py.test_method, "Test Method")
  map("<leader>dTs", dap_py.debug_selection, "Debug Selection")
end

-- Additional Plugins
table.insert(lvim.plugins, {
  -- You can switch between vritual environmnts.
  "mfussenegger/nvim-dap-python",
  config = dap_python_setup,
})
