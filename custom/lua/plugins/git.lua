return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                -- map("n", "]c", function()
                --     if vim.wo.diff then
                --         vim.cmd.normal({ "]c", bang = true })
                --     else
                --         gitsigns.nav_hunk("next")
                --     end
                -- end, { desc = "Jump to next git [c]hange" })
                --
                -- map("n", "[c", function()
                --     if vim.wo.diff then
                --         vim.cmd.normal({ "[c", bang = true })
                --     else
                --         gitsigns.nav_hunk("prev")
                --     end
                -- end, { desc = "Jump to previous git [c]hange" })

                -- Actions
                -- visual mode
                map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    { desc = "stage git hunk" })
                map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    { desc = "reset git hunk" })
                -- normal mode
                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
                map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
                map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
                map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
                map("n", "<leader>hb", gitsigns.blame_line, { desc = "git [b]lame line" })
                map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
                map("n", "<leader>hD", function() gitsigns.diffthis("@") end, { desc = "git [D]iff against last commit" })
                -- Toggles
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
                map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
            end,
        },
    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local neogit = require('neogit')
            vim.keymap.set('n', '<leader>Gs', neogit.open, { silent = true, noremap = true })
            vim.keymap.set('n', '<leader>Gc', ':Neogit commit<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<leader>Gp', ':Neogit pull<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<leader>GP', ':Neogit push<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<leader>Gb', ':Telescope git_branches<CR>', { silent = true, noremap = true })
            vim.keymap.set('n', '<leader>GB', ':G blame<CR>', { silent = true, noremap = true })
        end
    },
    {
        'polarmutex/git-worktree.nvim',
        version = '^2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        },
        config = function()
            require('telescope').load_extension('git_worktree')
            vim.keymap.set('n', '<leader>gw', ':')
        end
    }
}




-- require('gitsigns').setup {
--   signs = {
--     add = { text = '+' },
--     change = { text = '~' },
--     delete = { text = '_' },
--     topdelete = { text = '‾' },
--     changedelete = { text = '~' },
--   },
--   current_line_blame = false,
--   on_attach = function(bufnr)
--     local gs = package.loaded.gitsigns
--
--     local function map(mode, l, r, opts)
--       opts = opts or {}
--       opts.buffer = bufnr
--       vim.keymap.set(mode, l, r, opts)
--     end
--
--     -- Navigation
--     map('n', ']c', function()
--       if vim.wo.diff then return ']c' end
--       vim.schedule(function() gs.next_hunk() end)
--       return '<Ignore>'
--     end, {expr=true})
--
--     map('n', '[c', function()
--       if vim.wo.diff then return '[c' end
--       vim.schedule(function() gs.prev_hunk() end)
--       return '<Ignore>'
--     end, {expr=true})
--
--     -- Actions
--     map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
--     map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
--     map('n', '<leader>hS', gs.stage_buffer)
--     map('n', '<leader>ha', gs.stage_hunk)
--     map('n', '<leader>hu', gs.undo_stage_hunk)
--     map('n', '<leader>hR', gs.reset_buffer)
--     map('n', '<leader>hp', gs.preview_hunk)
--     map('n', '<leader>hb', function() gs.blame_line{full=true} end)
--     map('n', '<leader>tB', gs.toggle_current_line_blame)
--     map('n', '<leader>hd', gs.diffthis)
--     map('n', '<leader>hD', function() gs.diffthis('~') end)
--
--     -- Text object
--     map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
--   end
--
