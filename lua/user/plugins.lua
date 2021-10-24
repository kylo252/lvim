lvim.plugins = {

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
    config = [[ require("persistence").setup({dir = vim.fn.stdpath("cache") .. "/lvim_sessions/" }) ]],
  },
  -- Search
  {
    "jvgrootveld/telescope-zoxide",
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufWinEnter",
    config = [[require('user.lightspeed')]],
  },

  -- TMUX and session management
  {
    "aserowy/tmux.nvim",
    event = "VimEnter",
    config = [[require('user.tmux').setup()]],
  },

  -- UI
  -- {
  -- 	"kylo252/onedark.nvim",
  -- 	config = function()
  -- 		-- require("onedark").setup()
  -- 	end,
  -- },
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
    config = [[require('user.indent')]],
  },

  -- GIT
  {
    "ruifm/gitlinker.nvim",
    event = "BufWinEnter",
    config = [[require('gitlinker').setup()]],
  },
}
