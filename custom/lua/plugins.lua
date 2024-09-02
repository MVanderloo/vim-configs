-- lazy.nvim package manager
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

require("lazy").setup({
	spec = {
		require("plugins.general"),
		require("plugins.comments"),
		require("plugins.treesitter"),
		require("plugins.telescope"),
		require("plugins.ui"),
		require("plugins.lsp"),
		require("plugins.diagnostic"),
		require("plugins.git"),
		require("plugins.completions"),
		require("plugins.harpoon"),
	},
	-- defaults = { lazy = true },
	checker = { enabled = true },
	install = { colorscheme = { "catppuccin" } },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
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
