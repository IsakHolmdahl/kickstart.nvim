-- Some keymaps for standard vim, not for specific plugins

vim.keymap.set('i', 'ii', '<Esc>', { desc = 'Use ii to exit insert' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Use Escape to exit terminal' })

vim.keymap.set('n', '<M-l>', ':nohlsearch<CR>')

-- True delete (no yank)
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'dd', '"_dd', { noremap = true, silent = true })

-- Cut (yank + delete) with 'c'
vim.keymap.set({ 'n', 'v' }, '<leader>d', 'd', { noremap = true, silent = true, desc = 'Cut' })
vim.keymap.set('n', '<leader>D', 'D', { noremap = true, silent = true, desc = 'Cut' })

-- Some lsp
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover documentation' })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'LSP: [g]o to [I]mplementation' })
vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, { desc = 'LSP: [g]o to D[O]cument symbols' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'LSP: [r]e[n]ame' })
-- Calls incoming and outgoing calls
vim.keymap.set('n', 'gci', vim.lsp.buf.incoming_calls, { desc = 'LSP: [g]o to [c]alls [i]ncoming' })
vim.keymap.set('n', 'gco', vim.lsp.buf.outgoing_calls, { desc = 'LSP: [g]o to [c]alls [o]utgoing' })

-- Code action
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'LSP: Code [a]ction' })

vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save File' })
