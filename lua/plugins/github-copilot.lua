-- -----------------------
-- Github copilot settings
-- -----------------------

return {
  {
    'zbirenbaum/copilot.lua',
    commit = 'cc9b8c341323055d1780cf3c4877f6ccc61c3bfd',
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
        -- suggestion = {
        --   enabled = true,
        --   auto_trigger = true,
        --   debounce = 75,
        --   keymap = {
        --     accept = "<M-l>",
        --     accept_word = false,
        --     accept_line = false,
        --     next = "<M-->",
        --     prev = "<M-_>",
        --     dismiss = "<M-k>",
        --   },
        -- },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            -- Option + a
            accept = '<M-a>',
            -- Option + w
            accept_word = '<M-w>',
          },
        },
        nes = {
          enabled = false,
          keymap = {
            accept_and_goto = '<leader>å',
            accept = false,
            dismiss = '<esc>',
          },
        },
        panel = { enabled = false },
        filetypes = {
          --   yaml = false,
          markdown = true,
          --   help = false,
          --   gitcommit = false,
          --   gitrebase = false,
          --   hgcommit = false,
          --   svn = false,
          --   cvs = false,
          --   ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        copilot_model = 'claude-sonnet-4.5',
        -- server_opts_overrides = {
        --   on_init = function(client)
        --     local au = vim.api.nvim_create_augroup('copilotlsp.init', { clear = true })
        --     -- Use our vendored override that omits TextChangedI so NES only triggers
        --     -- while NOT in insert mode.
        --     require('utils.llm.patches.copilot_ls').lsp_on_init(client, au)
        --   end,
        -- },
      }
    end,
  },
}
