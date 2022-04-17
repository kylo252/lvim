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
    after = "telescope.nvim",
    config = function()
      require("user.telescope").setup_z()
    end,
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
    event = "BufReadPost",
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
    event = "BufReadPost",
    config = function()
      require("gitlinker").setup()
    end,
  },
  -- MISC
  {
    "michaelb/sniprun",
    run = "bash ./install.sh",
    config = function()
      require("user.sniprun").setup()
    end,
    event = "BufReadPost",
    opt = true,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    opt = true,
    after = "nvim-treesitter", -- You may want to specify Telescope here as well
    config = function()
      require("user.neorg").setup()
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
    requires = "nvim-treesitter/nvim-treesitter",
    opt = true,
  },
  ---}}}
}
