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

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      end

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

