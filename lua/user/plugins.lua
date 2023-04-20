local user_plugins = {

  -- LSP and linting
  { "p00f/clangd_extensions.nvim" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "nvim-treesitter/playground",
    config = function()
      lvim.builtin.treesitter.playground.enable = true
    end,
    cmd = "TSPlaygroundToggle",
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "BufReadPost",
    config = function()
      require("bqf").setup {
        auto_enable = true,
        preview = {
          auto_preview = false,
        },
      }
    end,
  },
  -- Search
  {
    "jvgrootveld/telescope-zoxide",
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufReadPost",
    config = function()
      require("user.lightspeed").setup()
    end,
  },
  -- TMUX and session management
  {
    "aserowy/tmux.nvim",
    event = "UIEnter",
    config = function()
      require("user.tmux").setup()
    end,
  },
  -- UI
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPost",
    config = function()
      require("neoscroll").setup { respect_scrolloff = true }
    end,
  },
  -- GIT
  {
    "ruifm/gitlinker.nvim",
    event = "BufReadPost",
    config = function()
      require("gitlinker").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup {}
    end,
    cmd = "DiffViewOpen",
  },
  -- MISC
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    config = function()
      require("user.sniprun").setup()
    end,
    event = "BufReadPost",
  },
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("user.zk").setup()
    end,
    cmd = "ZkNotes",
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-plenary",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-plenary",
        },
        default_strategy = "dap",
      }
    end,
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        enable = true,
        input_after_command = true,
      }
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    ft = { "rust" },
  },
  {
    "nvchad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup { filetypes = { "css", "scss", "html", "javascript" } }
    end,
    ft = { "css", "scss", "html", "javascript" },
  },
  ---}}}
}

for _, spec in ipairs(user_plugins) do
  spec.lazy = vim.F.if_nil(spec.lazy, true)
  spec.event = vim.F.if_nil(spec.event, { "VeryLazy" })
end

return user_plugins
