local M = {}

function M.setup()
  require("lightspeed").setup {
    ignore_case = false,
    exit_after_idle_msecs = { unlabeled = 1000, labeled = 1500 },
    -- s/x
    jump_to_unique_chars = { safety_timeout = 400 }, -- jump right after the first input, if the target character is unique in the search direction
    match_only_the_start_of_same_char_seqs = true, -- separator line will not snatch up all the available labels for `==` or `--`
    substitute_chars = { ["\r"] = "¬" }, -- highlighted matches by the given characters
    special_keys = { -- switch to the next/previous group of matches, when there are more matches than labels available
      next_match_group = "<space>",
      prev_match_group = "<tab>",
    },

    -- f/t
    limit_ft_matches = 4, -- For 1-character search, the next 'n' matches will be highlighted after [count]
    repeat_ft_with_target_char = false, -- repeat f/t motions by pressing the target character repeatedly
  }
end

return M
