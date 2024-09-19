-- options
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamedplus"

-- lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- packages
require("lazy").setup({
	spec = {
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			opts = { highlight = { enable = true } },
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy",
		},
		{ "numToStr/Comment.nvim", config = true },
		{ "echasnovski/mini.surround", config = true },
		{ "echasnovski/mini.ai", config = true },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- vscode specific settings
if vim.g.vscode then
	-- VSCode extension
	local vscode = require("vscode-neovim")

	-- Key mappings for VSCode actions
	vim.keymap.set("n", "<leader>f", function()
		vscode.action("workbench.action.quickOpen")
	end)
	vim.keymap.set("n", "<leader>e", function()
		vscode.action("workbench.action.toggleSidebarVisibility")
	end)
	vim.keymap.set("n", "<leader>x", function()
		vscode.action("workbench.action.closeActiveEditor")
	end)

	-- commenting
	vim.keymap.set("x", "gc", function()
		vscode.action("editor.action.commentLine")
	end)

	-- search
	vim.keymap.set("n", "<leader>s", function()
		vscode.action("workbench.action.findInFiles")
	end)

	-- navigation
	vim.keymap.set("n", "gd", function()
		vscode.action("editor.action.revealDefinition")
	end)
	vim.keymap.set("n", "gr", function()
		vscode.action("editor.action.goToReferences")
	end)

	vim.keymap.set("n", "[d", function()
		vscode.action("editor.action.marker.nextInFiles")
	end)
	vim.keymap.set("n", "]d", function()
		vscode.action("editor.action.marker.nextInFiles")
	end)
else
	-- Set anything that VSCode typically handles
	-- Just enough to make it a comfortable editor if launched independently
	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.expandtab = true
	vim.opt.number = true
	vim.opt.relativenumber = true

	vim.api.nvim_create_autocmd("BufReadPost", {
		callback = function(event)
			local exclude = { "gitcommit" }
			local buf = event.buf
			if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_cursor_loc then
				return
			end
			vim.b[buf].last_cursor_loc = true
			local mark = vim.api.nvim_buf_get_mark(buf, '"')
			local lcount = vim.api.nvim_buf_line_count(buf)
			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end,
	})
end

-- keybindings
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
-- Indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- autocommands
-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
