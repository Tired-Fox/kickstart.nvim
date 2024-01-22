return {
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            auto_close = true,
            use_diagnostic_signs = true,
        }
    },
    {
        'SmiteshP/nvim-navic',
        name = 'navic',
        dependencies = 'neovim/nvim-lspconfig',
        opts = {
            highlight = true,
        }
    },
    {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
            'neovim/nvim-lspconfig',
            'navic',
            'MunifTanjim/nui.nvim',
            -- Optional
            'numToStr/Comment.nvim',
            'nvim-telescope/telescope.nvim'
        },
        opts = {
            window = {
                border = 'rounded',
                size = '90%'
            }
        }
    },
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
        init = function()
            local extension_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
            local codelldb_path = extension_path .. 'adapter/codelldb'
            local liblldb_path = extension_path .. 'lldb/lib/liblldb'
            local this_os = vim.loop.os_uname().sysname;

            if this_os:find "Windows" then
                codelldb_path = extension_path .. 'adapter\\codelldb.exe'
                liblldb_path = extension_path .. 'lldb\\bin\\liblldb.dll'
            else
                liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
            end

            local cfg = require('rustaceanvim.config')
            vim.g.rustaceanvim = {
                tools = {
                    hover_actions = {
                        auto_focus=true
                    },
                    -- ref: api-win_config
                    float_win_config = {}
                },
                on_attach = function (client, bufnr)
                    local nmap = function(keys, func, desc)
                        if desc then
                            desc = 'LSP: ' .. desc
                        end
                    
                        vim.keymap.set('n', keys, func, { silent=true, buffer = bufnr, desc = desc })
                    end

                    nmap('<leader>a', function() vim.cmd.RustLsp('codeAction') end, 'Code Action')
                end,
                server = {
                    settings = {
                        ['rust-analyzer'] = {
                            checkOnSave = {
                                command = 'clippy'
                            }
                        }
                    }
                },
                dap = {
                    adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
                },
            }
        end
    },
    {
        'Saecki/crates.nvim',
        tag = 'stable',
        event = { 'BufRead Cargo.toml' },
        config = function()
            require('crates').setup()
        end
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
            'hrsh7th/cmp-path',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
}
