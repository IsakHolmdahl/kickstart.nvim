-- Some keymaps for standard vim, not for specific plugins

vim.keymap.set('i', 'ii', '<Esc>', { desc = 'Use ii to exit insert' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Use Escape to exit terminal' })

-- True delete (no yank)
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'dd', '"_dd', { noremap = true, silent = true })

-- Cut (yank + delete) with 'c'
vim.keymap.set({ 'n', 'v' }, '<leader>d', 'd', { noremap = true, silent = true, desc = 'Cut' })
vim.keymap.set('n', '<leader>D', 'D', { noremap = true, silent = true, desc = 'Cut' })

-- Some lsp
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', 'gb', vim.diagnostic.open_float, { desc = 'Hover Diagnostics' })
vim.keymap.set({ 'n', 'v' }, 'grl', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename' })

vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save File' })

vim.keymap.set('n', 'L', ':bnext<CR>', { desc = 'Next Tab' })
vim.keymap.set('n', 'H', ':bprevious<CR>', { desc = 'Previous Tab' })

vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { desc = 'Clear Search Highlighting' })
