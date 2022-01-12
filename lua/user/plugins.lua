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
  {
    "Shatur/neovim-session-manager",
    after = "telescope.nvim",
    config = function()
      require("session_manager").setup {
        sessions_dir = get_cache_dir() .. "/lvim_sessions", -- The directory where the session files will be saved.
        path_replacer = "__", -- The character to which the path separator will be replaced for session files.
        colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
        -- autoload_mode = require("session_manager.config").AutoloadMode.LastSession, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autoload_mode = false,
        autosave_last_session = true, -- Automatically save last session on exit.
        autosave_ignore_not_normal = true, -- Plugin will not save a session when no writable and listed buffers are opened.
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
      }
      -- require("telescope").load_extension "sessions"
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
}
