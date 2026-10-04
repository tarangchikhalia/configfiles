return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme tokyonight-night")
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			set_dark_mode = function()
				vim.cmd("colorscheme tokyonight-night")
			end,
			set_light_mode = function()
				vim.cmd("colorscheme tokyonight-day")
			end,
		},
	},
}
