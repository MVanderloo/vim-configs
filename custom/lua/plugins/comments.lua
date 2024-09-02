return {
	{
		"numToStr/Comment.nvim",
		config = true,
		-- opts = { ignore = '^$' } -- block comment doesn't include blank lines
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	}
}

-- -- This is the which-key config for this plugin. I'm not sure where I want to put which-key configs if I use them
-- local wk = require('which-key')
--
-- -- basic
-- wk.register({
--   gb = 'Togggle block comment',
--   gbc = 'Toggle block comment',
--   gc = 'Toggle line comment',
--   gcc = 'Toggle line comment',
-- }, { mode = "n" })
--
-- wk.register({
--   gb = 'Togggle block comment',
--   gc = 'Toggle line comment',
-- }, { mode = "x" })
--
-- -- extra
-- wk.register({
--   gco = 'Comment next line',
--   gcO = 'Comment prev line',
--   gcA = 'Comment end of line',
-- }, { mode = "n" })
--
-- -- extended
-- wk.register({
--   ["g>"] = 'Comment region',
--   ["g>c"] = 'Add line comment',
--   ["g>b"] = 'Add block comment',
--   ["g<lt>"] = 'Uncomment region',
--   ["g<lt>c"] = 'Remove line comment',
--   ["g<lt>b"] = 'Remove block comment',
-- }, { mode = "n" })
--
-- wk.register({
--   ["g>"] = 'Comment region',
--   ["g<lt>"] = 'Uncomment region',
-- }, { mode = "x" })
