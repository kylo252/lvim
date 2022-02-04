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
  -- MISC
  {
    "michaelb/sniprun",
    run = "bash ./install.sh",
    config = function()
      require("user.sniprun").setup()
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    after = "nvim-treesitter", -- You may want to specify Telescope here as well
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },
}
