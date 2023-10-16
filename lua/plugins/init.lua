return {
    -- NOTE: First, some plugins that don't require any configuration

    -- Better Netrw
    { "https://github.com/tpope/vim-vinegar.git", enabled = true },
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keymaps = {
            { "n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
        },
        config = function()
            require("oil").setup()
        end
    },

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim',                    opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                },
                pickers = {
                    buffers = {
                        theme = 'dropdown',
                        initial_mode = 'normal',
                        previewer = false,
                    },
                    find_files = {
                        theme = 'dropdown',
                        previewer = true,
                    },
                    search_headings = {
                        theme = 'dropdown',
                    },
                    insert_link = {
                        theme = 'dropdown',
                    },
                    insert_file_link = {
                        theme = 'dropdown',
                    }
                }
            })
            pcall(require('telescope').load_extension, 'fzf')
        end
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },

    {
        "Exafunction/codeium.vim",
        enabled = false,
        config = function()
            vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
            vim.keymap.set("i", "<c-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
            vim.keymap.set("i", "<c-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
            vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
            vim.keymap.set("n", "<leader>;", function()
                if vim.g.codeium_enabled == true then
                    vim.cmd "CodeiumDisable"
                else
                    vim.cmd "CodeiumEnable"
                end
            end, { noremap = true, desc = "Toggle Codeium active" })
        end
    },
}
