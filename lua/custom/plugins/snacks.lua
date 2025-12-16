return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    animate = { enabled = true },
    dashboard = {
      preset = {
        header = [[
__╱╲╲╲╲╲╲╲╲╲╲╲_____________________________________________        
 _╲╱╱╱╱╱╲╲╲╱╱╱______________________________________________       
  _____╲╱╲╲╲_________________________________________________      
   _____╲╱╲╲╲______╱╲╲╲╲╲╲╲╲╲╲╲_____╱╲╲╲╲╲╲╲╲______╱╲╲╲╲╲╲╲╲__     
    _____╲╱╲╲╲_____╲╱╱╱╱╱╱╱╲╲╲╱____╱╲╲╲╱╱╱╱╱╲╲╲___╱╲╲╲╱╱╱╱╱╲╲╲_    
     _____╲╱╲╲╲__________╱╲╲╲╱_____╱╲╲╲╲╲╲╲╲╲╲╲___╱╲╲╲╲╲╲╲╲╲╲╲__   
      _____╲╱╲╲╲________╱╲╲╲╱______╲╱╱╲╲╱╱╱╱╱╱╱___╲╱╱╲╲╱╱╱╱╱╱╱___  
       __╱╲╲╲╲╲╲╲╲╲╲╲__╱╲╲╲╲╲╲╲╲╲╲╲__╲╱╱╲╲╲╲╲╲╲╲╲╲__╲╱╱╲╲╲╲╲╲╲╲╲╲_ 
        _╲╱╱╱╱╱╱╱╱╱╱╱__╲╱╱╱╱╱╱╱╱╱╱╱____╲╱╱╱╱╱╱╱╱╱╱____╲╱╱╱╱╱╱╱╱╱╱__]],
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = { 1, 0 } },
        { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 2 },
        { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 2 },
        { section = 'startup' },
      },
    },
    explorer = {
      replace_netrw = true, -- Replace netrw with the snacks explorer
      trash = true, -- Use the system trash when deleting files
      diagnostics = true,
      git_status = true,
    },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      win = {
        list = {
          wo = {
            wrap = true,
          },
        },
        preview = {
          wo = {
            wrap = true,
          },
        },
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    toggle = { enabled = true },
    words = { enabled = true },
    gh = { enabled = true },
    lazygit = { enabled = true },
  },
  keys = function()
    return {
      -- My own
      {
        '\\',
        function()
          Snacks.explorer.open()
        end,
        desc = 'Open the file explorer tree to the side',
      },
      {
        '<leader>gz',
        function()
          Snacks.lazygit.open()
        end,
        desc = 'Open Lazygit',
      },
      -- Top Pickers & Explorer
      {
        '<leader><space>',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Smart Find Files',
      },
      {
        '<leader>,',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.grep()
        end,
        desc = 'CWD Grep',
      },
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>sn',
        function()
          Snacks.picker.notifications()
        end,
        desc = '[n]otification History',
      },
      {
        '<leader>e',
        function()
          Snacks.explorer()
        end,
        desc = 'File Explorer',
      },
      -- find
      {
        '<leader>fc',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = 'Config File',
      },
      {
        '<leader>fp',
        function()
          Snacks.picker.projects()
        end,
        desc = '[f]ind [p]rojects',
      },
      {
        '<leader>ff',
        function()
          Snacks.picker.files()
        end,
        desc = '[f]ind [f]iles',
      },
      {
        '<leader>fg',
        function()
          Snacks.picker.git_files()
        end,
        desc = '[f]ind [g]it files',
      },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent()
        end,
        desc = '[f]ind [r]ecent files',
      },
      -- git
      {
        '<leader>gb',
        function()
          Snacks.picker.git_branches()
        end,
        desc = '[g]it [b]ranches',
      },
      {
        '<leader>gl',
        function()
          Snacks.picker.git_log()
        end,
        desc = '[g]it [l]og',
      },
      {
        '<leader>gL',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = '[g]it [L]og (current line)',
      },
      {
        '<leader>gs',
        function()
          Snacks.picker.git_status()
        end,
        desc = '[g]it [s]tatus',
      },
      {
        '<leader>gS',
        function()
          Snacks.picker.git_stash()
        end,
        desc = '[g]it [S]tash',
      },
      {
        '<leader>gd',
        function()
          Snacks.picker.git_diff()
        end,
        desc = '[g]it [d]iff (hunks)',
      },
      {
        '<leader>gf',
        function()
          Snacks.picker.git_log_file()
        end,
        desc = '[g]it [f]ile [l]og',
      },
      -- gh
      {
        '<leader>gi',
        function()
          Snacks.picker.gh_issue()
        end,
        desc = 'GitHub Issues (open)',
      },
      {
        '<leader>gI',
        function()
          Snacks.picker.gh_issue { state = 'all' }
        end,
        desc = '[g]itHub [I]ssues (all)',
      },
      {
        '<leader>gp',
        function()
          Snacks.picker.gh_pr()
        end,
        desc = 'GitHub Pull Requests (open)',
      },
      {
        '<leader>gP',
        function()
          Snacks.picker.gh_pr { state = 'all' }
        end,
        desc = 'GitHub Pull Requests (all)',
      },
      -- Grep
      {
        '<leader>sb',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>sB',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = 'Grep Open Buffers',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      -- search
      {
        '<leader>s"',
        function()
          Snacks.picker.registers()
        end,
        desc = 'Registers',
      },
      {
        '<leader>s/',
        function()
          Snacks.picker.search_history()
        end,
        desc = 'History',
      },
      {
        '<leader>sa',
        function()
          Snacks.picker.autocmds()
        end,
        desc = 'Autocmds',
      },
      {
        '<leader>sb',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>sc',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>sC',
        function()
          Snacks.picker.commands()
        end,
        desc = 'Commands',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sD',
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = 'Buffer Diagnostics',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>sH',
        function()
          Snacks.picker.highlights()
        end,
        desc = 'Highlights',
      },
      {
        '<leader>si',
        function()
          Snacks.picker.icons()
        end,
        desc = 'Icons',
      },
      {
        '<leader>sj',
        function()
          Snacks.picker.jumps()
        end,
        desc = 'Jumps',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.loclist()
        end,
        desc = 'Location List',
      },
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>fM',
        function()
          Snacks.picker.man()
        end,
        desc = '[f]ind [M]anual Page',
      },
      {
        '<leader>sp',
        function()
          Snacks.picker.lazy()
        end,
        desc = 'Search for Plugin Spec',
      },
      {
        '<leader>sq',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Quickfix List',
      },
      {
        '<leader>sR',
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undo History',
      },
      {
        '<leader>uC',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = 'Colorschemes',
      },
      -- LSP
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = 'Goto Declaration',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        'gai',
        function()
          Snacks.picker.lsp_incoming_calls()
        end,
        desc = 'C[a]lls Incoming',
      },
      {
        'gao',
        function()
          Snacks.picker.lsp_outgoing_calls()
        end,
        desc = 'C[a]lls Outgoing',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>sS',
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
    }
  end,
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has 'nvim-0.11' == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd
        end

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'

        local Snacks = require 'snacks'
        local copilot_exists = pcall(require, 'copilot')

        if copilot_exists then
          Snacks.toggle({
            name = 'Copilot Completion',
            color = {
              enabled = 'azure',
              disabled = 'orange',
            },
            get = function()
              return not require('copilot.client').is_disabled()
            end,
            set = function(state)
              if state then
                require('copilot.command').enable()
              else
                require('copilot.command').disable()
              end
            end,
          }):map '<leader>ais'
        end
      end,
    })
  end,
}
