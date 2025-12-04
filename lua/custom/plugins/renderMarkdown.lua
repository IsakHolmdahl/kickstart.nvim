return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { 'markdown', 'codecompanion', 'copilot-chat' },
    render_modes = { 'n', 'c', 't', 'i', 'v', 'V', '\22' },
    completions = { lsp = { enabled = true } },
    -- anti_conceal = {
    --   enabled = false,
    --   disabled_modes = false, -- { 'n', 'c', 't' },
    --   ignore = {
    --     code_background = true,
    --     indent = true,
    --     sign = true,
    --     virtual_lines = true,
    --   },
    -- }
  },
}
