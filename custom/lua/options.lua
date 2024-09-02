local opt = vim.opt

-- Tab / Indentation
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = true
opt.breakindent = true

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
vim.opt.inccommand = "split"

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
opt.cmdheight = 1
vim.opt.cursorline = true
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Behavior
opt.autowriteall = true
opt.autowrite = true
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.cache/nvim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.iskeyword:append("-")
opt.selection = "exclusive"
opt.mouse = "a"
opt.modifiable = true
opt.encoding = "UTF-8"
opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Folds
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
