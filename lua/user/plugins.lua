lvim.plugins ={

	-- LSP and linting
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" },

	{
		"folke/persistence.nvim",
		event = "VimEnter",
		config = [[ require("persistence").setup({dir = vim.fn.stdpath("cache") .. "/lvim_sessions/" }) ]],
	},
	-- Search
		{
			"jvgrootveld/telescope-zoxide",
		},
		{
			"ggandor/lightspeed.nvim",
			event = "BufWinEnter",
			config = [[require('user.lightspeed')]],
		},

	-- TMUX and session management
		{
			"aserowy/tmux.nvim",
			event = "VimEnter",
			config = [[require('user.tmux').setup()]],
		},

	-- UI
		{
			"karb94/neoscroll.nvim",
			event = "BufRead",
			config = function()
				require("neoscroll").setup({ respect_scrolloff = true })
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			event = "VimEnter",
			config = [[require('user.indent')]],
		},

	-- GIT
		{
			"ruifm/gitlinker.nvim",
			event = "BufWinEnter",
		config = [[require('gitlinker').setup()]],
		},
}
