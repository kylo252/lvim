local M = {}

function M.config()
  return {
    picker = "telescope",
    lsp = {
      -- `config` is passed to `vim.lsp.start_client(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
        on_attach = function()
          require("lvim.lsp").common_on_attach()
          vim.cmd [[ setl foldmethod=indent foldlevel=0 ]]
        end,
      },
      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  }
end

function M.setup()
  local opts = M.config()
  require("zk").setup(opts)
end

return M
