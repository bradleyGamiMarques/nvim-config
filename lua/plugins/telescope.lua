return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {
        noremap = true, silent = true, desc = '[F]ind [F]iles'
      })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {
        noremap = true, silent = true, desc = '[F]ind [B]uffers'
      })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {
        noremap = true, silent = true, desc = '[F]ind by [G]rep'
      })
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {
        noremap = true, silent = true, desc = '[F]ind Document [S]ymbols'
      })
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').setup({
        extensions = {
          ['ui-select'] = require('telescope.themes').get_dropdown({})
        }
      })
      require('telescope').load_extension('ui-select')
    end
  },
}
