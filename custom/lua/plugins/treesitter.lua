return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
	},
	-- {
	--     "nvim-treesitter/nvim-treesitter-textobjects",
	--     dependencies = "nvim-treesitter/nvim-treesitter",
	--     config = function()
	--         require('nvim-treesitter.configs').setup({
	--             textobjects = {
	--                 select = {
	--                     enable = true,
	--                     lookahead = true,
	--                     keymaps = {
	--                         ['aa'] = '@parameter.outer',
	--                         ['ia'] = '@parameter.inner',
	--                         ['af'] = '@function.outer',
	--                         ['if'] = '@function.inner',
	--                         ['ac'] = '@class.outer',
	--                         ['ic'] = '@class.inner',
	--                         ['ii'] = '@conditional.inner',
	--                         ['ai'] = '@conditional.outer',
	--                         ['il'] = '@loop.inner',
	--                         ['al'] = '@loop.outer',
	--                         ['at'] = '@comment.outer',
	--                     },
	--                 },
	--                 move = {
	--                     enable = true,
	--                     set_jumps = true, -- whether to set jumps in the jumplist
	--                     goto_next_start = {
	--                         ["]m"] = "@function.outer",
	--                         ["]]"] = "@class.outer",
	--                     },
	--                     goto_next_end = {
	--                         ["]M"] = "@function.outer",
	--                         ["]["] = "@class.outer",
	--                     },
	--                     goto_previous_start = {
	--                         ["[m"] = "@function.outer",
	--                         ["[["] = "@class.outer",
	--                     },
	--                     goto_previous_end = {
	--                         ["[M"] = "@function.outer",
	--                         ["[]"] = "@class.outer",
	--                     },
	--                 },
	--             },
	--         })
	--     end
	-- }
}
-- require('nvim-treesitter.configs').setup {
--   -- Add languages to be installed here that you want installed for treesitter
--   highlight = { enable = true },
--   indent = { enable = true },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = '<c-space>',
--       node_incremental = '<c-space>',
--       scope_incremental = '<c-s>',
--       node_decremental = '<c-backspace>',
--     },
--   },
--   textobjects = {
--     select = {
--       enable = true,
--       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ['aa'] = '@parameter.outer',
--         ['ia'] = '@parameter.inner',
--         ['af'] = '@function.outer',
--         ['if'] = '@function.inner',
--         ['ac'] = '@class.outer',
--         ['ic'] = '@class.inner',
--         ['ii'] = '@conditional.inner',
--         ['ai'] = '@conditional.outer',
--         ['il'] = '@loop.inner',
--         ['al'] = '@loop.outer',
--         ['at'] = '@comment.outer',
--       },
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         [']f'] = '@function.outer',
--         [']]'] = '@class.outer',
--       },
--       goto_next_end = {
--         [']F'] = '@function.outer',
--         [']['] = '@class.outer',
--       },
--       goto_previous_start = {
--         ['[f'] = '@function.outer',
--         ['[['] = '@class.outer',
--       },
--       goto_previous_end = {
--         ['[F'] = '@function.outer',
--         ['[]'] = '@class.outer',
--       },
--     },
--     swap = {
--       enable = true,
--       swap_next = {
--         ['<leader>a'] = '@parameter.inner',
--       },
--       swap_previous = {
--         ['<leader>A'] = '@parameter.inner',
--       },
--     },
--   },
-- }
--
