local M = {}
lvim.keys = {
  ---@usage change or add keymappings for insert mode
  insert_mode = {
    -- 'jk' for quitting insert mode
    ["jk"] = "<ESC>",
    -- 'kj' for quitting insert mode
    ["kj"] = "<ESC>",
    -- 'jj' for quitting insert mode
    ["jj"] = "<ESC>",

    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-k>"] = "<Esc>:m .-2<CR>==gi",

    -- save file and quit insert-mode
    ["<C-s>"] = "<Esc><cmd>w<CR>",

    -- move the cursor
    ["<A-h>"] = "<Left>",
    ["<A-l>"] = "<Right>",
  },

  ---@usage change or add keymappings for normal mode
  normal_mode = {

    --live grep
    ["<M-f>"] = "<cmd>Telescope live_grep<CR>",

    -- Tab switch buffer
    ["<S-l>"] = ":BufferLineCycleNext<CR>",
    ["<S-h>"] = ":BufferLineCyclePrev<CR>",

    -- Move current line / block with Alt-j/k a la vscode.
    -- FIXME: this interferes with tmux
    -- ["<A-j>"] = ":m .+1<CR>==",
    -- ["<A-k>"] = ":m .-2<CR>==",

    -- QuickFix
    ["]q"] = ":cnext<CR>",
    ["[q"] = ":cprev<CR>",
    ["<C-q>"] = ":call QuickFixToggle()<CR>",

    -- save file
    ["<C-s>"] = ":w<CR>",

    -- Page down/up
    ["[d"] = "<PageUp>",
    ["]d"] = "<PageDown>",

    -- fix gx
    ["gx"] = "<cmd>lua require('user.utils').xdg_open_handler()<cr>",

    -- quick rename
    ["<F2>"] = ":%s@<c-r><c-w>@<c-r><c-w>@gc<c-f>$F@i",

    --find files
    ["<C-p>"] = "<cmd>lua require('user.telescope.custom-finders').find_project_files()<CR>",

    -- no one cares about ex mode
    ["<S-q>"] = "<cmd>BufferKill<cr>",
  },

  ---@usage change or add keymappings for terminal mode
  term_mode = {
    -- Terminal window navigation
  },

  ---@usage change or add keymappings for visual mode
  visual_mode = {
    -- Allow pasting same thing many times
    ["P"] = '"_dP',

    -- better indent
    [">"] = "<gv",
    ["<"] = ">gv",

    -- Visual mode pressing * or # searches for the current selection
    ["*"] = "<cmd>/\\<<C-r>=expand('<cword>')<CR>\\><CR>",
    ["#"] = "<cmd>?\\<<C-r>=expand('<cword>')<CR>\\><CR>",

    -- move selected line(s)
    ["K"] = ":move '<-2<CR>gv-gv",
    ["J"] = ":move '>+1<CR>gv-gv",

    -- only move one line at a time
    ["<S-Down>"] = "j",
    ["<S-Up"] = "k",

    -- search for visually selected text
    ["//"] = [[y/\V<C-R>=escape(@",'/\')<CR><CR>]],
  },

  ---@usage change or add keymappings for visual block mode
  visual_block_mode = {
    -- Allow pasting same thing many times
    ["p"] = '""p:let @"=@0<CR>',

    -- Move selected line / block of text in visual mode
    ["K"] = ":move '<-2<CR>gv-gv",
    ["J"] = ":move '>+1<CR>gv-gv",

    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",

    -- Sort lines
    ["<A-s>"] = "<esc>:'<,'>!sort -u<CR>",
  },
  ---@usage change or add keymappings for command mode
  command_mode = {
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
  },
}

require "user.whichkey"

return M
