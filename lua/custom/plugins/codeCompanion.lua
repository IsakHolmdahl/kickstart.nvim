return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {},
    event = 'VeryLazy',
    keys = {
      {
        '<leader>aia',
        '<cmd>CodeCompanionActions<cr>',
        mode = 'n',
        desc = 'Code Companion actions',
      },
      {
        '<leader>aic',
        '<cmd>CodeCompanionChat<cr>',
        mode = 'n',
        desc = 'Code Companion chat',
      },
      {
        '<leader>ait',
        '<cmd>CodeCompanionChat Toggle<cr>',
        mode = 'n',
        desc = 'Code Companion chat toggle',
      },
      {
        '<leader>aii',
        '<cmd>CodeCompanion<cr>',
        mode = 'n',
        desc = 'Code Companion inline',
      },
    },
    config = function()
      require('codecompanion').setup {
        opts = {
          log_level = 'DEBUG', -- or "TRACE"
        },
        chat = {
          fold_reasoning = true,
          icons = {
            chat_fold = ' ',
          },
        },
        strategies = {
          chat = {
            adapter = 'copilot',
          },
          inline = {
            adapter = 'copilot',
          },
          cmd = {
            adapter = 'copilot',
          },
        },
        display = {
          chat = {
            window = { position = 'right' },
          },
          diff = {
            provider = 'mini_diff',
          },
        },
        extensions = {
          mcphub = {
            callback = 'mcphub.extensions.codecompanion',
            opts = {
              -- MCP Tools
              make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
              show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
              add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
              show_result_in_chat = true, -- Show tool results directly in chat buffer
              format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
              -- MCP Resources
              make_vars = true, -- Convert MCP resources to #variables for prompts
              -- MCP Prompts
              make_slash_commands = true, -- Add MCP prompts as /slash commands
            },
          },
        },
      }
    end,
  },
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = 'VeryLazy',
    build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
    config = function()
      require('mcphub').setup {}
    end,
  },
}
