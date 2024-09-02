return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>so", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch in [O]pen Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	-- 	--  { "debugloop/telescope-undo.nvim",
	-- 	--    dependencies = {
	-- 	--      {
	-- 	--        "nvim-telescope/telescope.nvim",
	-- 	--        dependencies = { "nvim-lua/plenary.nvim" },
	-- 	--      },
	-- 	--    },
	-- 	--    keys = {
	-- 	--      { "<leader>u", "<cmd>Telescope undo<cr>", desc = "undo history", },
	-- 	--    },
	-- 	--    opts = {
	-- 	--      extensions = {
	-- 	--        undo = { use_delta = true },
	-- 	--      },
	-- 	--    },
	-- 	--    config = function(_, opts)
	-- 	--      require("telescope").setup(opts)
	-- 	--      require("telescope").load_extension("undo")
	-- 	--    end,
	-- 	--  },
}
--
-- require('telescope').setup {
--   defaults = {
--     layout_strategy = 'horizontal',
--     layout_config = {
--       preview_width = 0.65,
--       horizontal = {
--         size = {
--           width = '95%',
--           height = '95%',
--         },
--       },
--     },
--   pickers = {
--     find_files = {
--       theme = 'dropdown',
--     }
--   },
--     mappings = {
--       i = {
--         ['<C-u>'] = false,
--         ['<C-d>'] = false,
--         ['<C-n>'] = require('telescope.actions').move_selection_next,
--         ['<C-p>'] = require('telescope.actions').move_selection_previous,
--       },
--     },
--   },
-- }
--
-- -- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')
--
-- -- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = true,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer]' })
--
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>sS', require('telescope.builtin').git_status, { desc = '' })
-- vim.keymap.set('n', '<leader>sm', ':Telescope harpoon marks<CR>', { desc = 'Harpoon [M]arks' })
-- vim.keymap.set('n', '<Leader>sr', '<CMD>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>')
-- vim.keymap.set('n', '<Leader>sR', '<CMD>lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>')
-- vim.keymap.set('n', '<Leader>sn', '<CMD>lua require("telescope").extensions.notify.notify()<CR>')
--
-- vim.api.nvim_set_keymap('n', 'st', ':TodoTelescope<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<Leader><tab>', '<Cmd>lua require("telescope.builtin").commands()<CR>', {noremap=false})
--
-- --
-- -- local keys = {
-- -- 	{ '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer search' },
-- -- 	{ '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
-- -- 	{ '<leader>fc', '<cmd>Telescope git_commits<cr>', desc = 'Commits' },
-- -- 	{ '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find All Files' },
-- -- 	{ '<C-p>', '<cmd>Telescope git_files<cr>', desc = 'Git files' },
-- -- 	{ '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help' },
-- -- 	{ '<leader>fj', '<cmd>Telescope command_history<cr>', desc = 'History' },
-- -- 	{ '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
-- -- 	{ '<leader>fl', '<cmd>Telescope lsp_references<cr>', desc = 'Lsp References' },
-- -- 	{ '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = 'Old files' },
-- -- 	{ '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Ripgrep' },
-- -- 	{ '<leader>fs', '<cmd>Telescope grep_string<cr>', desc = 'Grep String' },
-- -- 	{ '<leader>ft', '<cmd>Telescope treesitter<cr>', desc = 'Treesitter' },
-- -- }
-- --
-- -- local config = function()
-- -- 	local telescope = require('telescope')
-- -- 	telescope.setup({
-- -- 		defaults = {
-- -- 			mappings = {
-- -- 				i = {
-- -- 					['<C-j>'] = 'move_selection_next',
-- -- 					['<C-k>'] = 'move_selection_previous',
-- -- 				},
-- -- 			},
-- -- 		},
-- -- 		pickers = {
-- -- 			live_grep = {
-- -- 				file_ignore_patterns = { 'node_modules', '.venv' },
-- -- 				additional_args = function(_)
-- -- 					return { '--hidden', '--no-ignore-vcs' }
-- -- 				end,
-- -- 				hidden = true,
-- -- 				no_ignore = true,
-- -- 			},
-- -- 			find_files = {
-- -- 				file_ignore_patterns = { 'node_modules', '.venv' },
-- -- 				additional_args = function(_)
-- -- 					return { '--hidden', '--no-ignore-vcs' }
-- -- 				end,
-- -- 				no_ignore = true,
-- -- 				hidden = true,
-- -- 			},
-- -- 		},
-- -- 		extensions = {
-- -- 			'fzf',
-- -- 		},
-- -- 	})
-- -- 	telescope.load_extension('fzf')
-- -- end
-- --
-- -- return {
-- -- 	'nvim-telescope/telescope.nvim',
-- -- 	dependencies = {
-- -- 		{ 'nvim-lua/plenary.nvim' },
-- -- 		{
-- -- 			'nvim-telescope/telescope-fzf-native.nvim',
-- -- 			build = 'make',
-- -- 		},
-- -- 	},
-- -- 	keys = keys,
-- -- 	config = config,
-- -- }
-- --
