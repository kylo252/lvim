vim.cmd [[command! -nargs=1 GS :lua require("telescope.builtin").grep_string(require("telescope.themes").get_dropdown({ prompt_title = "Fuzzy grep string " .. "<args>", search = "<args>" }))]]
vim.cmd [[ command! -nargs=* FuzzyGrepString :lua require('core.telescope.custom-actions').fuzzy_grep_string(<f-args>) ]]
vim.cmd [[ command! FindRuntimeFiles :lua require('core.telescope.custom-finders').find_runtime_files() ]]
