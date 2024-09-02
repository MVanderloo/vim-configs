return {
	{ "xiyaowong/nvim-transparent" },
	{ "catppuccin/nvim",       name = "catppuccin", lazy = true },
	{ "Mofiqul/vscode.nvim",   lazy = true },
	{ "0xstepit/flow.nvim",    lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "rebelot/kanagawa.nvim", lazy = true },
	{ "rose-pine/neovim",      name = "rose-pine",  lazy = true },
	{
		"zaldih/themery.nvim",
		opts = {
			themes = { "catppuccin", "vscode", "flow", "tokyonight", "kanagawa", "rose-pine" },
			livePreview = true,
		},
	},
	-- {
	--     'akinsho/bufferline.nvim',
	--     version = "*",
	--     dependencies = 'nvim-tree/nvim-web-devicons',
	--     config = function()
	--         vim.opt.mousemoveevent = true
	--         return {
	--             options = {
	--                 hover = {
	--                     enabled = true,
	--                     delay = 200,
	--                     reveal = { 'close' },
	--                 }
	--             }
	--         }
	--     end
	-- },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "filename", path = 1 },
					{ 'filetype', icon_only = true },
				},
				lualine_c = { "branch", "diff" },
				lualine_x = { "diagnostics" },
				lualine_y = {
					{ "searchcount", maxcount = 10000, timeout = 1000 },
					"progress",
				},
				lualine_z = { "location" },
			},
			-- inactive_sections = {
			--     lualine_a = {},
			--     lualine_b = {},
			--     lualine_c = { 'filename' },
			--     lualine_x = { 'location' },
			--     lualine_y = {},
			--     lualine_z = {}
			-- },
		},
	},
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		routes = {
	-- 			{
	-- 				filter = {
	-- 					event = "msg_show",
	-- 					any = {
	-- 						{ find = "%d+L, %d+B" },
	-- 						{ find = "; after #%d+" },
	-- 						{ find = "; before #%d+" },
	-- 						{ find = "%d fewer lines" },
	-- 						{ find = "%d more lines" },
	-- 					},
	-- 				},
	-- 				opts = { skip = true },
	-- 			},
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	}
	-- },
}
