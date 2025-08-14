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
        ensure_installed = { 'lua_ls', 'ts_ls', 'gopls' }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    -- Prettier via none-ls
    dependencies = { 'nvimtools/none-ls.nvim' },
    config = function()
      local lspconfig = require('lspconfig')

      -- Default keymap options
      local opts = { noremap = true, silent = true }

      -- on_attach function
      local on_attach = function(client, bufnr)
        -- You can add buffer-local mappings or logic here if needed
        -- Autoformat on save (Prettier via none-ls and any LSP that supports formating
        if client.supports_method and client:supports_method("textDocument/formatting") then
          local grp = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false })
          vim.api.nvim_clear_autocmds({ group = grp, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = grp,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end

      vim.keymap.set('n', '<leader>df', vim.lsp.buf.format, vim.tbl_extend('force', opts, { desc = '[F]ormat [B]uffer' }))
      vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover,
        vim.tbl_extend('force', opts, { desc = '[K] Hover Documentation' }))

      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition,
        vim.tbl_extend('force', opts, { desc = '[G]o to Definition' }))

      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references,
        vim.tbl_extend('force', opts, { desc = '[G]o to [R]eferences' }))

      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
        vim.tbl_extend('force', opts, { desc = '[C]ode [A]ction' }))
      vim.keymap.set('n', '[d',
        function() vim.diagnostic.jump({ count = -1, float = true }) end,
        { desc = 'Go to previous diagnostic' })

      vim.keymap.set('n', ']d',
        function() vim.diagnostic.jump({ count = 1, float = true }) end,
        { desc = 'Go to next diagnostic' })
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

      -- Go Language Server
      lspconfig.gopls.setup({
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      })

      -- none-ls for Prettier formatting
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          -- Prettier for common web formats
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript", "javascriptreact",
              "typescript", "typescriptreact",
              "json", "jsonc",
              "markdown", "markdown.mdx",
              "html", "css", "scss",
              "yaml", "yml"
            },
          }),
        },
        on_attach = on_attach,
      })
    end
  }
}
