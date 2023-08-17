return {
    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'onedark'
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1001,
        config = function()
            require('catppuccin').setup({
                flavour = "frappe",
                background = {
                    dark = "frappe",
                    light = "latte",
                },
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    treesitter = true
                }
            })
            vim.cmd("colorscheme catppuccin")
        end
    },
}
