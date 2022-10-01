return {

  -- LSP and linting
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "nvim-treesitter/playground",
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
  },
  -- MISC
  { "gpanders/editorconfig.nvim" },
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
    "mickael-menu/zk-nvim",
    config = function()
      require("user.zk").setup()
    end,
  },
  {
    "nvim-neotest/neotest",
    requires = {
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
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup {
        tools = {
          autoSetHints = true,
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          on_init = require("lvim.lsp").common_on_init,
          on_attach = function(client, bufnr)
            require("lvim.lsp").common_on_attach(client, bufnr)
            local rt = require "rust-tools"
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      }
    end,
    ft = { "rust", "rs" },
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
