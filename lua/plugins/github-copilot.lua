-- -----------------------
-- Github copilot settings
-- -----------------------

return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      'copilotlsp-nvim/copilot-lsp',
      init = function()
        vim.g.copilot_nes_debounce = 300 -- 300 ms
        vim.g.copilot_nes_debounce_insert = 5000 -- 5 seconds
      end,
    },
    enabled = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          trigger_on_accept = true,
          keymap = {
            accept = '<C-a>',
            accept_word = '<C-s>',
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
      }
    end,
  },
}
