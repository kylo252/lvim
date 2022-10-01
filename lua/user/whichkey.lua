lvim.builtin.which_key.mappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
  ["<Space>"] = { ":BufferNext<CR>", "Go to the next buffer" },
  b = {
    name = "+buffers",
    b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
    f = { "<cmd>Telescope buffers<CR>", "buffers" },
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
    D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
    L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
    y = { "<cmd>lua require('utils').copy_help_url()<cr>", "copy help URL" },
  },
  d = {
    name = "+dotfiles",
    d = { require("user.telescope.custom-finders").find_dotfiles, "Find dotfiles" },
    g = { require("user.telescope.custom-finders").grep_dotfiles, "Find dotfiles" },
  },
  e = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },
  f = {
    name = "+Find",
    b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current buffer fuzzy-find" },
    f = { "<cmd>lua require('user.telescope.custom-finders').find_project_files()<CR>", "Find files" },
    g = { "<cmd>lua require('user.telescope.custom-finders').grep_string_v2()<CR>", "grep string v2" },
    h = { "<cmd>Telescope help_tags<CR>", "help tags" },
    j = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
    l = { "<cmd>DynamicGrep<CR>", "DynamicGrep" },
    m = { "<cmd>Telescope marks<CR>", "Marks" },
    p = { "<cmd>lua require('user.telescope.custom-finders').find_files_local()<CR>", "Find files (local)" },
    r = { "<cmd>Telescope oldfiles<CR>", "Find recent files" },
    t = {
      function()
        require("user.telescope.custom-finders").dynamic_grep { args = "ft=" .. vim.bo.filetype }
      end,
      "live grep (same filetype)",
    },
    i = {
      name = "+internal",
      c = { "<cmd>Telescope commands<CR>", "commands" },
      h = { "<cmd>Telescope help_tags<CR>", "help tags" },
      m = { "<cmd>Telescope marks<CR>", "Marks" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      r = { "<cmd>Telescope registers<CR>", "Registers" },
      C = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    },
    J = { "<cmd>FindRuntimeFiles<CR>", "Find runtime files" },
    L = { "<cmd>lua require('user.telescope.custom-finders').local_buffer_fuzzy_grep()<CR>", "Local fuzzy grep" },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    P = { "<cmd>Telescope projects<CR>", "Find recent projects" },
    R = { "<cmd>Telescope oldfiles cwd_only=true<CR>", "Find recent files (local)" },
  },
  g = {
    name = "+git",
    a = { "<cmd>Telescope git_commits<cr>", "commits" },
    b = { "<cmd>Telescope git_bcommits<cr>", "Buffers commits" },
    d = { "<cmd>! fman-tmux -c 'git dots-lazy'<cr>", "Lazydots" },
    g = { "<cmd>! fman-tmux -c lazygit<cr>", "Lazygit" },
    Y = {
      b = {
        function()
          require("user.git").get_github_blame_url { remote = "origin" }
        end,
        "Copy blame URL",
      },
      r = {
        function()
          require("gitlinker").get_repo_url { remote = "origin" }
        end,
        "Copy repo URL",
      },
      y = {
        function()
          require_safe("gitlinker").get_buf_range_url("n", { remote = "origin" })
        end,
        "Copy line URL (origin)",
      },
    },
    y = {
      function()
        require_safe("gitlinker").get_buf_range_url "n"
      end,
      "Copy line URL",
    },
    j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
    l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    S = { "<cmd>Telescope git_status<cr>", "Git status" },
    T = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Blame" },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Buffer Diagnostics" },
    w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    f = { require("lvim.lsp.utils").format, "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Mason Info" },
    j = {
      vim.diagnostic.goto_next,
      "Next Diagnostic",
    },
    k = {
      vim.diagnostic.goto_prev,
      "Prev Diagnostic",
    },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    p = {
      name = "Peek",
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
  },
  j = { "<cmd>BufferPick<cr>", "magic buffer-picking mode" },
  h = { "<cmd>nohlsearch<CR>", "No Highlight" },
  S = {
    name = "+sessions",
    d = { "<cmd>lua require('persistence').stop()<cr>", "stop saving" },
    l = { "<cmd>lua require('persistance').load()<cr>", "restore the session for the current directory" },
    r = { "<cmd>lua require('persistence').load({ last = true })<cr>)", "restore the last session" },
    s = { "<cmd>lua require('persistence').save()<cr>", "save session" },
    f = { "<cmd>lua require('persistence').list()<cr>", "list sessions" },
  },
  t = {
    name = "+scratch test",
    a = { "<cmd>lua require_clean('scratch').test1()<cr>", "scratch test1" },
    s = { "<cmd>lua require_clean('scratch').test2()<cr>", "scratch test2" },
    e = { "<cmd>edit ~/.config/lvim/lua/scratch.lua<cr>", "edit scratch file" },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lvim.plugin-loader').cache_reset()<cr>", "Re-compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  z = {
    name = "+zettel",
    j = { "<cmd>ZkNotes<cr>", "notes" },
    n = { "<cmd>ZkNew<cr>", "new" },
    t = { "<cmd>ZkNewFromContentSelection<cr>", "new from selection" },
  },

  L = {
    name = "+LunarVim",
    c = {
      "<cmd>edit ~/.config/lvim/config.lua<cr>",
      "Edit config.lua",
    },
    C = {
      "<cmd>lua require('user.telescope.custom-finders').find_lvim_config()<cr>",
      "Find lvim config files",
    },
    f = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>",
      "Find LunarVim files",
    },
    g = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>",
      "Grep LunarVim files",
    },
    k = { "<cmd>Telescope keymaps<cr>", "View LunarVim's keymappings" },
    i = {
      "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>",
      "Toggle LunarVim Info",
    },
    I = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
      "View LunarVim's changelog",
    },
    l = {
      name = "+logs",
      d = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
        "view default log",
      },
      D = {
        "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
        "Open the default logfile",
      },
      l = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>",
        "view lsp log",
      },
      L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
      n = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
        "view neovim log",
      },
      N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
      p = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(get_cache_dir() .. '/packer.nvim.log')<cr>",
        "view packer log",
      },
      P = { "<cmd>edit $LUNARVIM_CACHE_DIR/packer.nvim.log<cr>", "Open the Packer logfile" },
    },
    r = { "<cmd>LvimReload<cr>", "Reload LunarVim's configuration" },
    u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
  },
  T = {
    name = "Treesitter",
    f = { ":TSNodeUnderCursor<cr>", "Node under cursor" },
    c = { ":TSCaptureUnderCursor<cr>", "Capture under Cursor" },
    i = { ":TSConfigInfo<cr>", "Config info" },
    t = { ":TSPlaygroundToggle<cr>", "Playground" },
  },
}

lvim.builtin.which_key.vmappings = {
  ["kc"] = { "<ESC><CMD>lua require('Comment.api').gc(vim.fn.visualmode())<CR>", "Comment" },
  ["kb"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment" },
  ["<leader>gy"] = {
    function()
      require_safe("gitlinker").get_buf_range_url "v"
    end,
    "Copy range URL",
  },
  ["<leader>gY"] = {
    function()
      require_safe("gitlinker").get_buf_range_url("v", { remote = "origin" })
    end,
    "Copy range URL (origin)",
  },
}

local select_labels = {
  ["."] = "@textsubject-smart",
  [";"] = "@textsubject-container-outer",
  ["i;"] = "@textsubject-container-inner",
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ak"] = "@comment.outer",
  ["ac"] = "@class.outer",
  ["ic"] = "@class.inner",
  ["aa"] = "@parameter.inner", -- "ap" is already used
  ["ia"] = "@parameter.outer", -- "ip" is already used
  ["iF"] = "(function_definition) @function",
}

local move_labels = {
  ["]m"] = "@function.outer",
  ["]]"] = "@class.outer",
  ["]M"] = "@function.outer",
  ["]["] = "@class.outer",
  ["[m"] = "@function.outer",
  ["[["] = "@class.outer",
  ["[M"] = "@function.outer",
  ["[]"] = "@class.outer",
  ["]k"] = "@comment.outer",
  ["[k"] = "@comment.outer",
  ["]K"] = "@comment.outer",
  ["[K"] = "@comment.outer",
}

local lsp_ts_labels = {
  ["gpof"] = "@function.outer",
  ["gpoc"] = "@class.outer",
}

local setup_opts = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = { -- adds help for operators like d, y, ...
      operators = {
        v = false,
        d = false,
      },
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
}

lvim.builtin.which_key.setup = setup_opts

lvim.builtin.which_key.on_config_done = function(wk)
  wk.register(select_labels, { mode = "o", prefix = "", preset = true })
  wk.register(move_labels, { mode = "n", prefix = "", preset = true })
  wk.register(lsp_ts_labels, { mode = "n", prefix = "", preset = true })
end
