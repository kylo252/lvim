return {

  -- LSP and linting
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    config = function()
      lvim.builtin.treesitter.playground.enable = true
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
    config = function()
      require("bqf").setup {
        auto_enable = true,
        preview = {
          auto_preview = false,
        },
      }
    end,
  },
  {
    "folke/persistence.nvim",
    event = "VimEnter",
    config = function()
      require("persistence").setup {
        dir = get_cache_dir() .. "/lvim_sessions/",
      }
    end,
  },
  -- Search
  {
    "jvgrootveld/telescope-zoxide",
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufWinEnter",
    config = function()
      require("user.lightspeed").setup()
    end,
  },

  -- TMUX and session management
  {
    "aserowy/tmux.nvim",
    event = "BufRead",
    config = function()
      require("user.tmux").setup()
    end,
  },
  -- UI
  {
    "goolord/alpha-nvim",
    event = "BufWinEnter",
    config = function()
      require("user.dashboard").setup()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      lvim.builtin.bufferline.active = false
      require("user.bufferline").setup()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "BufRead",
    config = function()
      require("neoscroll").setup { respect_scrolloff = true }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
      require("user.indent").setup()
    end,
  },
  -- GIT
  {
    "ruifm/gitlinker.nvim",
    event = "BufWinEnter",
    config = function()
      require("gitlinker").setup()
    end,
  },
  { "folke/lua-dev.nvim" },
}
