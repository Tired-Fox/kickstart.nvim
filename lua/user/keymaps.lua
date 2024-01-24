-- [[ Basic Keymaps ]]

-- Set keymap leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set local leader
vim.api.nvim_set_keymap('', '<LocalLeader>', '<Nop>', { silent = true });
vim.g.maplocalleader = ',';
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move line or selection up and down
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('n', '<A-j>', ":m .+1<cr>==", { desc = 'Move selection down' })
vim.keymap.set('n', '<A-k>', ":m .-2<cr>==", { desc = 'Move selection down' })
vim.keymap.set('i', '<A-j>', "<ESC>:m .+1<cr>==gi", { desc = 'Move selection down' })
vim.keymap.set('i', '<A-k>', "<ESC>:m .-2<cr>==gi", { desc = 'Move selection down' })

-- Buffer interaction
vim.keymap.set('n', ']b', ":bnext<cr>", { desc = "[B]uffer [N]ext" })
vim.keymap.set('n', '[b', ":bprevious<cr>", { desc = "[B]uffer [P]revious" })

-- Open Netrw
vim.keymap.set('n', '<leader>o', ":Oil --float<cr>", { desc = "[N]tree" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
