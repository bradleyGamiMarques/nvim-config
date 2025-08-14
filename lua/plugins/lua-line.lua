return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '', right = '', right_padding = 2 }},
          },
          lualine_b = {
            { 'filename', 'branch'},
          },
          lualine_c = {},
          lualine_x = {
            { "fileformat", symbols = { unix = "" } }
          },
          lualine_z = {
            { 'location', separator = {right = '', left = '' }, left_padding = 2 },
          }
        },
        options = {
          theme = {
            normal = {
              a = { fg = '#2a2139', bg = '#00f9f9', gui = 'bold' },
              b = { fg = '#f8f8f2', bg = '#4f4946' },
              c = { fg = '#f8f8f2', bg = '#2a2139' },
            },
            insert = {
              a = { fg = '#2a2139', bg = '#f92aad', gui = 'bold' },
            },
            visual = {
              a = { fg = '#2a2139', bg = '#a5ff90', gui = 'bold' },
            },
            replace = {
              a = { fg = '#2a2139', bg = '#f97ef2', gui = 'bold' },
            },
            command = {
              a = { fg = '#2a2139', bg = '#fede5d', gui = 'bold' },
            },
            inactive = {
              a = { fg = '#7e5fa5', bg = '#2a2139', gui = 'bold' },
              b = { fg = '#7e5fa5', bg = '#2a2139' },
              c = { fg = '#7e5fa5', bg = '#2a2139' },
            }
          }
        }
      })
    end,
  }
}
