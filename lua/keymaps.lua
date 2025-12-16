-- Some keymaps for standard vim, not for specific plugins

vim.keymap.set('i', 'ii', '<Esc>', { desc = 'Use ii to exit insert' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Use Escape to exit terminal' })

vim.keymap.set('n', '<leader>vt', [[<cmd>vsplit | term<cr>A]], { desc = 'Open terminal in vertical split' })
vim.keymap.set('n', '<leader>ht', [[<cmd>split | term<cr>A]], { desc = 'Open terminal in horizontal split' })

vim.keymap.set('n', '<C-L>', ':nohlsearch<CR>')

-- True delete (no yank)
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'dd', '"_dd', { noremap = true, silent = true })

-- Cut (yank + delete) with 'c'
vim.keymap.set({ 'n', 'v' }, '<leader>d', 'd', { noremap = true, silent = true, desc = 'Cut' })
vim.keymap.set('n', '<leader>D', 'D', { noremap = true, silent = true, desc = 'Cut' })
