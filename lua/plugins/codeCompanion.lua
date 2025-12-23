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
        ignore_warnings = true,
        opts = {
          -- log_level = "DEBUG", -- or "TRACE"
        },
        prompt_library = {
          ['sequential thinking'] = require 'utils.llm.prompts.sequential_thinking',
          ['research-and-implement'] = require 'utils.llm.prompts.research_and_implement',
          ['plan-and-code'] = require 'utils.llm.prompts.plan_and_code',
        },
        chat = {
          fold_reasoning = true,
          icons = {
            chat_fold = ' ',
          },
        },
        interactions = {
          -- Change the default chat adapter and model
          chat = {
            adapter = 'copilot',
            model = 'claude-sonnet-4.5',
            opts = {
              system_prompt = require 'utils.llm.prompts.system_prompt',
            },
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
            model = 'claude-sonnet-4.5',
          },
          cmd = {
            adapter = 'copilot',
            model = 'claude-sonnet-4.5',
          },
        },
        display = {
          action_palette = {
            width = 140,
            height = 10,
            prompt = 'Prompt ', -- Prompt used for interactive LLM calls
            provider = 'default', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
            opts = {
              show_preset_actions = true, -- Show the preset actions in the action palette?
              show_preset_prompts = true, -- Show the preset prompts in the action palette?
              title = 'CodeCompanion actions', -- The title of the action palette
            },
          },
          chat = {
            window = { position = 'right' },
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

      pcall(function()
        require('utils.llm.patches.tool-input-logger').setup()
      end)
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
            CONTEXT7_API_KEY = os.getenv 'CONTEXT7_API_KEY' or '',
            DEFAULT_MINIMUM_TOKENS = '10000',
            USER = os.getenv 'USER' or 'isak',
          }

          if os.getenv 'OBSIDIAN_API_KEY' then
            mcp_env.OBSIDIAN_API_KEY = os.getenv 'OBSIDIAN_API_KEY'
          end

          -- if current OS = darwin, set MCP_MEMORY_PATH to /users/${USER}/Library/Mobile Documents/com~apple~CloudDocs/.aim, otherwise /home/${USER}/.aim
          if vim.loop.os_uname().sysname == 'Darwin' then
            mcp_env.MCP_MEMORY_PATH = vim.fn.expand('/Users/' .. mcp_env.USER .. '/Library/Mobile Documents/com~apple~CloudDocs/.aim')
          else
            mcp_env.MCP_MEMORY_PATH = vim.fn.expand('/home/' .. mcp_env.USER .. '/.aim')
          end

          print(mcp_env.MCP_MEMORY_PATH)

          -- Git settings
          local git_root = nil
          local is_git_repo = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1] == 'true'
          if is_git_repo then
            git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
          end
          if git_root then
            mcp_env.REPOSITORY_PATH = git_root
          end

          -- vim.notify('MCP HUB Starting')

          return mcp_env
        end,
      }
    end,
  },
}
