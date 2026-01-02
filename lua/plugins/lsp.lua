return {
  {
    'williamboman/mason.nvim',
    config = function()
      -- setup mason with default properties
      require('mason').setup()
    end,
  },
  -- install utils and binaries for mason
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          -- LSP
          'lua-language-server',
          'jdtls',
          'typescript-language-server',
          -- Debug and Test Utils
          'java-debug-adapter',
          'java-test',
          -- linter and formatters
          'stylua',
          'google-java-format',
          'checkstyle',
          'eslint_d',
          'prettier',
        },
      }
    end,
  },
  -- bridge mason and lspconfig to auto-setup servers
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup {
        automatic_installation = true,
      }
    end,
  }, -- utility plugin for configuring the java language server for us
  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
      vim.keymap.set('n', 'gb', vim.diagnostic.open_float, { desc = 'Hover Diagnostics' })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[g]oto [d]efinition' })
      vim.keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, { desc = 'Code [a]ction' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[g]oto [r]eferences' })
      vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[g]oto [I]mplementations' })
      vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = '[r]e[n]ame' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[g]oto [D]eclaration' })
    end,
  },
}
