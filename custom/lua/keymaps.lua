local keymap = vim.keymap

-- Remove any delay for space as leader key
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- j and k will move to the character visually below the cursor, to deal with line wrap
-- don't use this behavior if there is a count so that relative line numbering is true
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Have Esc clear highlighted search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keep highlight when indenting block
keymap.set("v", "<", "<gv", { silent = true, noremap = true })
keymap.set("v", ">", ">gv", { silent = true, noremap = true })

-- move between panes
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Make n and N stateless (n is always down and N is always up)
keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add diagnostics to the quickfix list
vim.keymap.set("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "[D]iagnostic" })

-- Oil.nvim
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- persistence.nvim
keymap.set("n", "<leader>ps", function() require("persistence").load() end)                -- load the session for the current directory
keymap.set("n", "<leader>pS", function() require("persistence").select() end)              -- select a session to load
keymap.set("n", "<leader>pl", function() require("persistence").load({ last = true }) end) -- load the last session
keymap.set("n", "<leader>pd", function() require("persistence").stop() end)                --  session won't be saved on exit


-- read scrolloff value from input
vim.keymap.set("n", "<leader>ts", function()
	local input = tonumber(vim.fn.input("Scrolloff: "))
	vim.opt.scrolloff = input
end, { noremap = true, silent = true, desc = "Set scrolloff value" })


vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
