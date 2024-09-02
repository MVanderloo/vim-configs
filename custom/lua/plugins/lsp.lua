return {


    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim",       config = true },
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { desc = "LSP: " .. desc })
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("gI", require("telescope.builtin").lsp_implementations,
                        "[G]oto [I]mplementation")
                    map("gD", require("telescope.builtin").lsp_type_definitions,
                        "[G]oto Type [D]efinition")
                    map("<leader>fs", require("telescope.builtin").lsp_document_symbols,
                        "Document [S]ymbols")
                    map("<leader>fS", require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "Workspace [S]ymbols")
                    map("<leader>cr", vim.lsp.buf.rename, "[R]ename")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities,
                require("cmp_nvim_lsp").default_capabilities())

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                -- clangd = {},
                -- gopls = {},
                -- pyright = {},
                -- rust_analyzer = {},
                -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                --
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- But for many setups, the LSP (`tsserver`) will work just fine
                -- tsserver = {},
                --

                lua_ls = {
                    -- cmd = {...},
                    -- filetypes = { ...},
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            -- Ensure the servers and tools above are installed
            --  To check the current status of installed tools and/or manually install
            --  other tools, you can run
            --    :Mason
            --
            --  You can press `g?` for help in this menu.
            require("mason").setup()

            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua", -- Used to format Lua code
            })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities,
                            server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
    -- {
    -- 	"williamboman/mason.nvim",
    -- 	config = function()
    -- 		require("mason").setup()
    -- 	end,
    -- },
    -- {
    -- 	"williamboman/mason-lspconfig.nvim",
    -- 	config = function()
    -- 		require("mason-lspconfig").setup({
    -- 			ensure_installed = {
    -- 				"lua_ls",
    -- 			},
    -- 		})
    -- 	end,
    -- },
    -- {
    -- 	"neovim/nvim-lspconfig",
    -- 	config = function()
    -- 		local lspconfig = require("lspconfig")
    --
    -- 		-- Set up each LSP server
    -- 		lspconfig.lua_ls.setup({
    -- 			Lua = {
    -- 				runtime = {
    -- 					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
    -- 					version = "LuaJIT",
    -- 				},
    -- 				diagnostics = {
    -- 					-- Get the language server to recognize the `vim` global
    -- 					globals = { "vim" },
    -- 				},
    -- 				workspace = {
    -- 					-- Make the server aware of Neovim runtime files
    -- 					library = vim.api.nvim_get_runtime_file("", true),
    -- 				},
    -- 				-- Do not send telemetry data containing a randomized but unique identifier
    -- 				telemetry = {
    -- 					enable = false,
    -- 				},
    -- 			},
    -- 		})
    --
    -- 		-- Global mappings
    -- 		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    -- 		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    -- 		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
    -- 		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
    --
    -- 		-- Use LspAttach autocommand to only map the following keys
    -- 		-- after the language server attaches to the current buffer
    -- 		vim.api.nvim_create_autocmd("LspAttach", {
    -- 			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    -- 			callback = function(ev)
    -- 				local opts = { buffer = ev.buf }
    -- 				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    -- 				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- 				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- 				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- 				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- 				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    -- 				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    -- 				vim.keymap.set("n", "<leader>wl", function()
    -- 					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- 				end, opts)
    -- 				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    -- 				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    -- 				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    -- 				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    -- 				vim.keymap.set("n", "<leader>f", function()
    -- 					vim.lsp.buf.format({ async = true })
    -- 				end, opts)
    -- 			end,
    -- 		})
    -- 	end,
    -- },
}
-- -- LSP settings.
-- --  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(_, bufnr)
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--   nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--   nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--   nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--   nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--   -- Lesser used LSP functionality
--   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--   nmap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist Folders')
--
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     if vim.lsp.buf.format then
--       vim.lsp.buf.format()
--     elseif vim.lsp.buf.formatting then
--       vim.lsp.buf.formatting()
--     end
--   end, { desc = 'Format current buffer with LSP' })
-- end
--
-- require('mason').setup()
--
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'gopls'  }
--
-- -- Ensure the servers above are installed
-- require('mason-lspconfig').setup {
--   ensure_installed = servers,
-- }
--
-- -- nvim-cmp supports additional completion capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- for _, lsp in ipairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end
--
-- -- Turn on lsp status information
-- require('fidget').setup()
--
-- -- Example custom configuration for lua
-- --
-- -- Make runtime files discoverable to the server
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')
--
-- require('lspconfig').lua_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         globals = { 'vim' },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file('', true),
--         checkThirdParty = false,
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = { enable = false },
--     },
--   },
-- }
-- --
-- -- nvim-cmp setup
-- local cmp = require 'cmp'
-- local luasnip = require 'luasnip'
--
-- cmp.setup {
--   view = {
--   	entries = "native"
--   },
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert {
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--     { name = "neorg" },
--   },
-- }
--
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'sh',
--   callback = function()
--     vim.lsp.start({
--       name = 'bash-language-server',
--       cmd = { 'bash-language-server', 'start' },
--     })
--   end,
-- })
