lvim.builtin.project.datapath = vim.fn.stdpath "cache" .. "/lvim"
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.nvimtree.disable_window_picker = 1

return {

  -- LSP and linting
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" },

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
      require("persistence").setup { dir = vim.fn.stdpath "cache" .. "/lvim_sessions/" }
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
      require "user.lightspeed"
    end,
  },

  -- TMUX and session management
  {
    "aserowy/tmux.nvim",
    event = "VimEnter",
    config = function()
      require("user.tmux").setup()
    end,
  },

  -- UI
  {
    "karb94/neoscroll.nvim",
    event = "BufRead",
    config = function()
      require("neoscroll").setup { respect_scrolloff = true }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VimEnter",
    config = function()
      require "user.indent"
    end,
  },

  { "chrisbra/Colorizer", cmd = "ColorToggle", opt = true },
  -- GIT
  {
    "ruifm/gitlinker.nvim",
    event = "BufWinEnter",
    config = function()
      require("gitlinker").setup()
    end,
  },
}
