local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { exe = "stylua" } }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { exe = "luacheck" } }

local server_opts = {
  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "lvim" },
      },
      workspace = {
        library = {
          [require("lvim.utils").join_paths(get_runtime_dir(), "lvim", "lua")] = true,
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

local status_ok, lua_dev = pcall(require, "lua-dev")
if status_ok then
  server_opts = lua_dev.setup {
    library = {
      vimruntime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      -- plugins = false, -- installed opt or start plugins in packpath
      -- you can also specify the list of plugins to make available as a workspace library
      -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },

    lspconfig = server_opts,
  }
end

local servers = require "nvim-lsp-installer.servers"
local server_available, requested_server = servers.get_server "sumneko_lua"

if server_available then
  server_opts.cmd = requested_server:get_default_options().cmd
end

require("lvim.lsp.manager").setup("sumneko_lua", server_opts)
