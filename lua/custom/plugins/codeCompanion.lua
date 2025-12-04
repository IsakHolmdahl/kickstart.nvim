return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'franco-ruggeri/codecompanion-spinner.nvim',
    },
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
          -- Change the default chat adapter and model
          chat = {
            adapter = 'copilot',
            opts = {},
            tools = {
              opts = {
                default_tools = {
                  'memories',
                },
              },
            },
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
          action_palette = {
            width = 95,
            height = 10,
            prompt = 'Prompt ', -- Prompt used for interactive LLM calls
            provider = 'default', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
            opts = {
              show_default_actions = true, -- Show the default actions in the action palette?
              show_default_prompt_library = true, -- Show the default prompt library in the action palette?
              title = 'CodeCompanion actions', -- The title of the action palette
            },
          },
        },
        extensions = {
          spinner = {},
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
      require('mcphub').setup {
        config = vim.fn.expand '~/.config/nvim/mcphub/servers.json',
        global_env = function(_context)
          local mcp_env = {
            GITHUB_PERSONAL_ACCESS_TOKEN = os.getenv 'GITHUB_PERSONAL_ACCESS_TOKEN' or '',
            REF_MCP_API_KEY = os.getenv 'REF_MCP_API_KEY' or '',
            CONTEXT7_API_KEY = os.getenv 'CONTEXT7_API_KEY' or '',
            DEFAULT_MINIMUM_TOKENS = '10000',
            OPEN_API_KEY = os.getenv 'OPEN_API_KEY' or '',
            USER = os.getenv 'USER' or 'Peter',
          }

          -- if SSL_CERT_FILE exists add it to mcp_ENV
          if os.getenv 'SSL_CERT_FILE' then
            mcp_env.SSL_CERT_FILE = os.getenv 'SSL_CERT_FILE'
          end
          if os.getenv 'UV_NATIVE_TLS' then
            mcp_env.UV_NATIVE_TLS = os.getenv 'UV_NATIVE_TLS'
          end
          if os.getenv 'TAVY_API_KEY' then
            mcp_env.TAVY_API_KEY = os.getenv 'TAVY_API_KEY'
          end
          if os.getenv 'NOTION_API_TOKEN' then
            mcp_env.NOTION_API_TOKEN = os.getenv 'NOTION_API_TOKEN'
          end
          if os.getenv 'OBSIDIAN_API_KEY' then
            mcp_env.OBSIDIAN_API_KEY = os.getenv 'OBSIDIAN_API_KEY'
          end

          -- Git settings
          local git_root = nil
          local is_git_repo = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
          if is_git_repo then
            git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
          end
          if git_root then
            mcp_env.REPOSITORY_PATH = git_root
          end

          vim.notify 'MCP HUB Starting'

          return mcp_env
        end,
      }
    end,
  },
}
