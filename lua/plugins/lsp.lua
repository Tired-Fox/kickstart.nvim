return {
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
        config = function()
            local cmp = require("cmp")
            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
                pattern = "Cargo.toml",
                callback = function()
                    cmp.setup.buffer({ sources = { { name = "crates" } } })
                end
            })
        end
    },

    {
        'simrat39/rust-tools.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    local rt = require('rust-tools')
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                end
            },
            inlay_hints = {
                only_current_line = true,

            }
        }
    },
    {
        'saecki/crates.nvim',
        tag = 'v0.4.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local crates = require('crates')
            crates.setup({
                src = {
                    cmp = {
                        enable = true
                    }
                },
                open_programs = { "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome" },
                popup = {
                    border = "rounded"
                }
            })

            vim.keymap.set('n', '<leader>ct', crates.toggle, { desc = "Toggle", silent = true })
            vim.keymap.set('n', '<leader>cr', crates.reload, { desc = "Reload", silent = true })

            vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, { desc = "Show Versions", silent = true })
            vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { desc = "Show Features", silent = true })
            vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup,
                { desc = "Show Dependencies", silent = true })

            vim.keymap.set('n', '<leader>cu', crates.update_crate, { desc = "Update Crate", silent = true })
            vim.keymap.set('v', '<leader>cu', crates.update_crates, { desc = "Update Crates", silent = true })
            vim.keymap.set('n', '<leader>ca', crates.update_all_crates, { desc = "Update All Crates", silent = true })
            vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { desc = "Upgrade Crate", silent = true })
            vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { desc = "Upgrade Crates", silent = true })
            vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, { desc = "Upgrade All Crates", silent = true })

            vim.keymap.set('n', '<leader>ce', crates.expand_plain_crate_to_inline_table,
                { desc = "Expand plain crate to inline table", silent = true })
            vim.keymap.set('n', '<leader>cE', crates.extract_crate_into_table,
                { desc = "Extract crate into table", silent = true })

            vim.keymap.set('n', '<leader>cH', crates.open_homepage, { desc = "Open Homepage", silent = true })
            vim.keymap.set('n', '<leader>cR', crates.open_repository, { desc = "Open Repository", silent = true })
            vim.keymap.set('n', '<leader>cD', crates.open_documentation, { desc = "Open Documentation", silent = true })
            vim.keymap.set('n', '<leader>cC', crates.open_crates_io, { desc = "Open Crates IO", silent = true })
        end
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        init = function()
            require("nvim-treesitter.install").compilers = { "gcc" }
            require('nvim-treesitter.parsers').get_parser_configs().asm = {
                install_info = {
                    url = 'https://github.com/rush-rs/tree-sitter-asm.git',
                    files = { 'src/parser.c' },
                    branch = 'main',
                },
            }
        end,
        opts = {
            ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

            -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
            auto_install = false,

            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<M-space>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
            },
        }
    },
}
