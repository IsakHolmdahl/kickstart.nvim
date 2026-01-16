-- filepath: lua/plugins/smart-splits.lua
return {
  'mrjones2014/smart-splits.nvim',
  build = './kitty/install-kittens.bash',
  lazy = false,
  keys = {
    -- resizing splits
    {
      '<A-h>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'Resize split left',
      mode = 'n',
    },
    {
      '<A-j>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'Resize split down',
      mode = 'n',
    },
    {
      '<A-k>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'Resize split up',
      mode = 'n',
    },
    {
      '<A-l>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'Resize split right',
      mode = 'n',
    },
    -- moving between splits
    {
      '<C-h>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'Move to left split',
      mode = 'n',
    },
    {
      '<C-j>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'Move to below split',
      mode = 'n',
    },
    {
      '<C-k>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'Move to above split',
      mode = 'n',
    },
    {
      '<C-l>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = 'Move to right split',
      mode = 'n',
    },
    {
      '<C-\\>',
      function()
        require('smart-splits').move_cursor_previous()
      end,
      desc = 'Move to previous split',
      mode = 'n',
    },
    -- swapping buffers between windows
    {
      '<leader>ph',
      function()
        require('smart-splits').swap_buf_left()
      end,
      desc = 'Swap buffer left',
      mode = 'n',
    },
    {
      '<leader>pj',
      function()
        require('smart-splits').swap_buf_down()
      end,
      desc = 'Swap buffer down',
      mode = 'n',
    },
    {
      '<leader>pk',
      function()
        require('smart-splits').swap_buf_up()
      end,
      desc = 'Swap buffer up',
      mode = 'n',
    },
    {
      '<leader>pl',
      function()
        require('smart-splits').swap_buf_right()
      end,
      desc = 'Swap buffer right',
      mode = 'n',
    },
  },
}
