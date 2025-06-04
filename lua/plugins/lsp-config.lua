return {
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'ts_ls' }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      -- Default keymap options
      local opts = { noremap = true, silent = true }

      -- on_attach function
      local on_attach = function(client, bufnr)
        -- You can add buffer-local mappings or logic here if needed
      end

      vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover,
        vim.tbl_extend('force', opts, { desc = '[K] Hover Documentation' }))

      vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition,
        vim.tbl_extend('force', opts, { desc = '[G]o to Definition' }))

      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references,
        vim.tbl_extend('force', opts, { desc = '[G]o to [R]eferences' }))

      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
        vim.tbl_extend('force', opts, { desc = '[C]ode [A]ction' }))

      vim.keymap.set('n', '[d', function()
        vim.diagnostic.goto_prev({ count = vim.v.count > 0 and vim.v.count or 1 })
      end, vim.tbl_extend('force', opts, { desc = '[G]o to Previous Diagnostic' }))

      vim.keymap.set('n', ']d', function()
        vim.diagnostic.goto_next({ count = vim.v.count > 0 and vim.v.count or 1 })
      end, vim.tbl_extend('force', opts, { desc = '[G]o to Next Diagnostic' }))

      -- Toggle diagnostic location list
      vim.keymap.set('n', '<leader>dl', function()
        local wininfo = vim.fn.getwininfo()
        local loclist_open = false

        for _, win in ipairs(wininfo) do
          if win.loclist == 1 then
            loclist_open = true
            break
          end
        end

        if loclist_open then
          vim.cmd('lclose')
        else
          vim.diagnostic.setloclist()
          vim.cmd('lopen')
        end
      end, vim.tbl_extend('force', opts, { desc = 'Open [D]iagnostics List' }))

      -- Lua Language Server
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })

      -- TypeScript/JavaScript Server
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          on_attach(client, bufnr)
        end,
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
      })
    end
  }
}
