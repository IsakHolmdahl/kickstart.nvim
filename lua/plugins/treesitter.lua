return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
      lazy = false,
      init = function()
        -- Disable entire built-in ftplugin mappings to avoid conflicts.
        -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
        vim.g.no_plugin_maps = true

        -- Or, disable per filetype (add as you like)
      end,
      config = function()
        require('nvim-treesitter-textobjects').setup {
          select = {
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = false,
          },
        }

        -- keymaps
        -- You can use the capture groups defined in `textobjects.scm`
        vim.keymap.set({ 'x', 'o' }, 'af', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
        end, { desc = 'function' })
        vim.keymap.set({ 'x', 'o' }, 'if', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
        end, { desc = 'function' })
        vim.keymap.set({ 'x', 'o' }, 'ac', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
        end, { desc = 'class' })
        vim.keymap.set({ 'x', 'o' }, 'ic', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
        end, { desc = 'class' })
        -- You can also use captures from other query groups like `locals.scm`
        vim.keymap.set({ 'x', 'o' }, 'as', function()
          require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')
        end, { desc = 'local scope' })

        local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

        -- Repeat movement with ; and ,
        -- ensure ; goes forward and , goes backward regardless of the last direction
        vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

        -- vim way: ; goes to the direction you were moving.
        -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = {
        max_lines = 4,
        multiline_threshold = 2,
      },
    },
  },
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- State tracking for async parser loading
    local parsers_loaded = {}
    local parsers_pending = {}
    local parsers_failed = {}

    local ns = vim.api.nvim_create_namespace 'treesitter.async'

    -- Helper to start highlighting and indentation
    local function start(buf, lang)
      local ok = pcall(vim.treesitter.start, buf, lang)
      if ok then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
      return ok
    end

    -- Install core parsers after lazy.nvim finishes loading all plugins
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyDone',
      once = true,
      callback = function()
        ts.install({
          'bash',
          'comment',
          'css',
          'diff',
          'git_config',
          'git_rebase',
          'gitcommit',
          'gitignore',
          'html',
          'javascript',
          'json',
          'lua',
          'luadoc',
          'make',
          'markdown',
          'markdown_inline',
          'python',
          'query',
          'regex',
          'scss',
          'toml',
          'tsx',
          'typescript',
          'typst',
          'vim',
          'vimdoc',
          'vue',
          'xml',
          'yaml',
          'go',
          'java',
          'csv',
          'zsh',
        }, {
          max_jobs = 8,
        })
      end,
    })

    -- Decoration provider for async parser loading
    vim.api.nvim_set_decoration_provider(ns, {
      on_start = vim.schedule_wrap(function()
        if #parsers_pending == 0 then
          return false
        end
        for _, data in ipairs(parsers_pending) do
          if vim.api.nvim_buf_is_valid(data.buf) then
            if start(data.buf, data.lang) then
              parsers_loaded[data.lang] = true
            else
              parsers_failed[data.lang] = true
            end
          end
        end
        parsers_pending = {}
      end),
    })

    local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

    local ignore_filetypes = {
      'checkhealth',
      'lazy',
      'mason',
      'snacks_dashboard',
      'snacks_notif',
      'snacks_win',
      'noice',
      'blink_cmp_menu',
      'blink_cmp_documentation',
      'snacks_picker_preview',
      'snacks_picker_list',
      'blink-cmp-menu',
      'snacks_picker_input',
      'snacks_layout_box',
      'snacks_win_backdrop',
    }

    -- Auto-install parsers and enable highlighting on FileType
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      desc = 'Enable treesitter highlighting and indentation (non-blocking)',
      callback = function(event)
        if vim.tbl_contains(ignore_filetypes, event.match) then
          return
        end

        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf

        if parsers_failed[lang] then
          return
        end

        if parsers_loaded[lang] then
          -- Parser already loaded, start immediately (fast path)
          start(buf, lang)
        else
          -- Queue for async loading
          table.insert(parsers_pending, { buf = buf, lang = lang })
        end

        -- Auto-install missing parsers (async, no-op if already installed)
        ts.install { lang }
      end,
    })
  end,
}
