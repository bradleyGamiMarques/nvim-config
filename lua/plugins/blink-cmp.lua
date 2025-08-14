return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets', 'onsails/lspkind.nvim', },
  version = '1.6.0',
  --@module 'blink.cmp'
  --@type blink.cmp.Config
  opts = {
    signature = {
      enabled = true,
      window = {
        min_width = 1,
        max_width = 250,
        max_height = 250,
        winblend = 10,
        direction_priority = {'s', 'n'},
        winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
      }
    },
    keymap = { preset = 'enter' },
    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "path" }, ctx.source_name) then
                  local dev_icon = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require("lspkind").symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end
                return icon .. (ctx.icon_gap or " ")
              end,
              highlight = function (ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({"path"}, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      ghost_text = { enabled = true },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  config = function (_, opts)
    require("blink.cmp").setup(opts)

    vim.api.nvim_set_hl(0, "BlinkCmpGhostText", {
      fg = "#a5ff90",
      italic = true,
    })

    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", {
      bg = "#2a2139",
      fg = "#ff7edb",
      italic = true,
    })

    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", {
      bg = "#2a2139",
      fg = "#ff7edb",
    })
  end,
}

