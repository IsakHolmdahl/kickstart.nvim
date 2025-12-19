vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('grn', vim.lsp.buf.rename, '[r]e[n]ame')

    map('gra', vim.lsp.buf.code_action, '[g]oto Code [a]ction', { 'n', 'x' })

    map('grD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed

    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client then
      -- Only set up document highlight if the server supports it
      if client:supports_method 'textDocument/documentHighlight' then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })
      end

      vim.api.nvim_create_autocmd('LspDetach', {
        buffer = event.buf, -- Add buffer scoping
        group = highlight_augroup, -- Use same group
        callback = function(event2)
          vim.lsp.buf.clear_references(event2.buf)
          -- Clear only this buffer's autocmds from this group
          vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = event2.buf }
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    map('<leader>uth', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, '[t]oggle Inlay [h]ints')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function(args)
    require('jdtls.jdtls_setup'):setup()
  end,
})

-- Make sure blink capabilities are available to all LSP servers
if vim.fn.has 'nvim-0.11' == 1 then
  vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
  })
end
