return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- ui plugins to make debugging simplier
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    -- gain access to the dap plugin and its functions
    local dap = require 'dap'
    -- gain access to the dap ui plugin and its functions
    local dapui = require 'dapui'

    -- Setup the dap ui with default configuration
    dapui.setup()

    -- setup an event listener for when the debugger is launched
    dap.listeners.before.launch.dapui_config = function()
      -- when the debugger is launched open up the debug ui
      dapui.open()
    end

    vim.keymap.set('n', '<leader>bt', dap.toggle_breakpoint, { desc = 'De[b]ug [t]oggle Breakpoint' })

    vim.keymap.set('n', '<leader>bs', dap.continue, { desc = 'De[b]ug [s]tart' })

    -- set a vim motion to close the debugging ui
    vim.keymap.set('n', '<leader>bc', dapui.close, { desc = 'De[b]ug [c]lose' })
  end,
}
