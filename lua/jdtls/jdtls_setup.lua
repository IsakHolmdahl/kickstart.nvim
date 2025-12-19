-- Taken from https://github.com/LukeElrod/nvim/blob/master/lua/jdtls/jdtls_setup.lua

-- jdtls is managed outside of Mason via: brew install jdtls
-- Lombok jar should be placed at: ~/.local/share/nvim/lombok.jar
-- This setup is intentional - jdtls needs specialized configuration
-- that mason-lspconfig doesn't handle well.
--
--
-- IMPORTANT: If things are not working, perhaps super not found or other, try creating nessecary eclipse files for the java project Run the following command in the root of your java project:
--    mvn eclipse:eclipse
--    This will generate the .project and .classpath files that jdtls uses to identify the project structure.
local M = {}

function M:setup()
  if vim.fn.exepath 'jdtls' == '' then
    vim.notify('jdtls not installed. Install via: brew install jdtls', vim.log.levels.WARN)
    return
  end
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = vim.fn.stdpath 'data' .. package.config:sub(1, 1) .. 'jdtls-workspace' .. package.config:sub(1, 1) .. project_name

  local lombok_jar = vim.fn.expand '~/.local/share/nvim/lombok.jar'

  local config = {
    name = 'jdtls',
    cmd = {
      'jdtls',
      '--jvm-arg=-javaagent:' .. lombok_jar,
      '--jvm-arg=-Xbootclasspath/a:' .. lombok_jar,
      '-data',
      workspace_dir,
    },
    root_dir = vim.fs.root(0, { '.classpath', '.project', 'gradlew', '.git', 'mvnw', 'pom.xml' }),
    -- CRITICAL: Maven monorepo configuration
    settings = {
      java = {
        -- Enable Maven support
        maven = {
          downloadSources = true,
        },
        -- Tell jdtls to treat this as a Maven project
        configuration = {
          targetPathMismatch = { 'ignore' },
          updateBuildConfiguration = 'automatic',
        },
        -- Import Maven project structure
        project = {
          import = {
            maven = {
              enabled = true,
            },
          },
        },
        -- Handle monorepo/multi-module
        references = {
          includeDecompiledSources = true,
        },
        contentProvider = {
          preferred = 'fernflower',
        },
        -- Completion and formatting
        completion = {
          favoriteStaticMembers = {
            'org.hamcrest.MatcherAssert.assertThat',
            'org.hamcrest.Matchers.*',
            'org.junit.jupiter.api.Assertions.*',
          },
        },
      },
    },
    init_options = {
      bundles = {},
      workspace = {
        -- Build status reporting
        status = { refreshAfterStatusChanges = 1 },
      },
    },
  }

  require('jdtls').start_or_attach(config)
end

return M
