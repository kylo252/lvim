lvim.builtin.which_key.mappings = {
  ["<Space>"] = { ":BufferNext<CR>", "Go to the next buffer" },
  b = {
    name = "+barbar",
    b = { "<cmd>Telescope buffers theme=get_ivy<CR>", "buffers" },
    q = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
    e = { "<cmd>BufferCloseAllButCurrent<cr>", "close all but current buffer" },
    h = { "<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left" },
    l = { "<cmd>BufferCloseBuffersRight<cr>", "close all BufferLines to the right" },
    d = { "<cmd>BufferOrderByDirectory<cr>", "sort BufferLines automatically by directory" },
    L = { "<cmd>BufferOrderByLanguage<cr>", "sort BufferLines automatically by language" },
  },
  d = {
    name = "+dotfiles",
    d = { "<cmd>lua require('user.telescope.custom-finders').find_dotfiles()<CR>", "Find dotfiles" },
    g = { "<cmd>lua require('user.telescope.custom-finders').grep_dotfiles()<CR>", "Find dotfiles" },
  },
  e = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },
  f = {
    name = "+Find",
    -- f = { "<cmd>Telescope find_files<CR>", "Find Files" },
    f = { require("user.telescope.custom-finders").find_project_files, "Find File" },
    g = { "<cmd>lua require('user.telescope.custom-finders').live_grep_v2()<CR>", "Live Grep v2" },
    h = { "<cmd>Telescope help_tags<CR>", "help tags" },
    j = { "<cmd>Telescope zoxide list theme=get_ivy<CR>", "Zoxide" },
    l = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
    m = { "<cmd>Telescope marks theme=get_ivy<CR>", "Marks" },
    p = { "<cmd>Telescope git_files<CR>", "Find Project Files" },
    r = { "<cmd>Telescope oldfiles cwd_only=true theme=get_ivy<CR>", "Find recent files (local)" },
    i = {
      name = "+internal",
      c = { "<cmd>Telescope commands<CR>", "commands" },
      h = { "<cmd>Telescope help_tags<CR>", "help tags" },
      m = { "<cmd>Telescope marks<CR>", "Marks" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      r = { "<cmd>Telescope registers<CR>", "Registers" },
      C = {
        "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    },
    G = { "<cmd>lua require('user.telescope.custom-finders').grep_string_v2()<CR>", "Grep String v2" },
    J = { "<cmd>lua require('user.telescope.custom-finders').find_runtime_files()<CR>", "Find runtime files" },
    L = {
      "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={vim.fn.expand(\"%:p\")} }<cr>",
      "Local live-grep",
    },
    M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    R = { "<cmd>Telescope oldfiles theme=get_ivy<CR>", "Find recent files" },
  },
  g = {
    name = "+git",
    b = { "<cmd>Telescope git_bcommits theme=get_ivy<cr>", "Buffers commits" },
    c = {
      b = {
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".copy_to_clipboard })<cr>',
        "Copy buffer URL",
      },
    },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  },
  j = { "<cmd>BufferPick<cr>", "magic buffer-picking mode" },
  l = {
    name = "LSP",
    a = { "<cmd>lua require('lvim.core.telescope').code_actions()<cr>", "Code Action" },
    c = {
      "<cmd>lua dump(require('lvim.lsp.utils').get_client_capabilities(3))<cr>",
      "Show language-server capabilities",
    },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    p = {
      name = "Peek",
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    Q = { "<cmd>Telescope quickfix<cr>", "Quickfix (Telescope)" },
  },
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
        "<cmd>lua require('lvim.core.terminal').toggle_log_view('packer.nvim')<cr>",
        "view packer log",
      },
      P = { "<cmd>exe 'edit '.stdpath('cache').'/packer.nvim.log'<cr>", "Open the Packer logfile" },
    },
    r = { "<cmd>LvimReload<cr>", "Reload LunarVim's configuration" },
    u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
  },
  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<cr>", "Info" },
  },
}

lvim.builtin.which_key.vmappings = {
  ["/"] = { "<ESC><CMD>lua require('Comment.api').gc(vim.fn.visualmode())<CR>", "Comment" },
  ["lf"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format" },
}
