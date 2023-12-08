-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
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
vim.keymap.set('n', '<leader>q', ":bdelete!<cr>", { desc = "[C]lose [B]uffer" })
vim.keymap.set('n', ']b', ":bnext<cr>", { desc = "[B]uffer [N]ext" })
vim.keymap.set('n', '[b', ":bprevious<cr>", { desc = "[B]uffer [P]revious" })

-- Open Netrw
vim.keymap.set('n', '<leader>o', ":Oil --float<cr>", { desc = "[N]tree" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Telescope keymaps
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set(
    'n',
    '<leader>/',
    function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end,
    { desc = '[/] Fuzzily search in current buffer' }
)
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
