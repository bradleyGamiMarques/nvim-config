return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Toggle the filesystem view with Ctrl+n (on the right)
    vim.keymap.set('n', '<leader>n', function()
      require('neo-tree.command').execute({
        toggle = true,
        dir = vim.loop.cwd(),
        source = "filesystem",
        position = "right",  
      })
    end, { desc = "Toggle Neo-tree filesystem (right)" })

    -- Focus the filesystem if it's open
    vim.keymap.set('n', '<leader>e', function()
      require('neo-tree.command').execute({
        action = "focus",
        source = "filesystem",
        position = "right",
      })
    end, { desc = "Focus Neo-tree filesystem (right)" })

    -- Close the filesystem
    vim.keymap.set('n', '<leader>c', function()
      require('neo-tree.command').execute({
        action = "close",
        source = "filesystem",
        position = "right",
      })
    end, { desc = "Close Neo-tree filesystem (right)" })end,
}

