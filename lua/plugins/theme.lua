return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = "macchiato",
                background = {
                    dark = "mocha",
                    light = "latte",
                },
                integrations = {
                    navic = {
                        enabled = true,
                    },
                    cmp = true,
                    gitsigns = true,
                    treesitter = true
                }
            })
            vim.cmd("colorscheme catppuccin")
        end
    }
}
