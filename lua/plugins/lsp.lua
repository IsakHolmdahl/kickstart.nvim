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
        automatic_enable = {
          exclude = {
            'jdtls',
          },
        },
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
  },
}
