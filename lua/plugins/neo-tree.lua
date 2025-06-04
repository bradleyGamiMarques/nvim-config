return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Keymaps
    vim.keymap.set('n', '<leader>n', function()
      require('neo-tree.command').execute({
        toggle = true,
        dir = vim.loop.cwd(),
        source = "filesystem",
        position = "right",
      })
    end, { desc = "Toggle Neo-tree filesystem (right)" })

    vim.keymap.set('n', '<leader>e', function()
      require('neo-tree.command').execute({
        action = "focus",
        source = "filesystem",
        position = "right",
      })
    end, { desc = "Focus Neo-tree filesystem (right)" })

    -- Configure Neo-tree
    require('neo-tree').setup({
      filesystem = {
        filtered_items = {
          visible = true,          -- Show hidden files (dotfiles)
          show_hidden_count = true,
          hide_dotfiles = false,   -- Do not hide dotfiles
          hide_gitignored = false, -- Show gitignored files
        },
      },
    })

    -- Auto-apply Synthwave84 color highlights
    local function apply_synthwave84_highlights()
      vim.cmd [[
        highlight NeoTreeDirectoryName guifg=#f92aad
        highlight NeoTreeFileName guifg=#fafff9
        highlight NeoTreeFileNameOpened guifg=#fdf200 gui=bold
        highlight NeoTreeGitModified guifg=#ff8b39
        highlight NeoTreeGitAdded guifg=#00ffcc
        highlight NeoTreeGitDeleted guifg=#ff005e
        highlight NeoTreeIndentMarker guifg=#7e57c2
        ]]
    end

    -- Apply now and whenever the colorscheme changes
    apply_synthwave84_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = apply_synthwave84_highlights,
    })
  end,
}

