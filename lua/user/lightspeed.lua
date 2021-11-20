local M = {}

function M.setup()
  require("lightspeed").setup {
    exit_after_idle_msecs = { labeled = 1500, unlabeled = 1000 },
    -- jump_to_first_match = true,

    -- s/x
    grey_out_search_area = true,
    highlight_unique_chars = true,
    match_only_the_start_of_same_char_seqs = true,
    jump_on_partial_input_safety_timeout = 400,
    substitute_chars = { ["\r"] = "¬" },
    -- Leaving the appropriate list empty effectively disables
    -- "smart" mode, and forces auto-jump to be on or off.
    cycle_group_fwd_key = "<tab>",
    cycle_group_bwd_key = "<c-tab>",

    -- f/t
    limit_ft_matches = 4,
    instant_repeat_fwd_key = nil,
    instant_repeat_bwd_key = nil,
  }
end

return M
