return { -- Autocompletion
  'saghen/blink.cmp',
  -- provides snippets for the snippet source, and used for custom snippets in core/snippets.lua
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
  },

  -- Use a release tag to download pre-built binaries.
  -- Pinned to the 1.x line: blink.cmp v2 (main branch) requires the separate
  -- "saghen/blink.lib" plugin, which isn't installed here and crashes startup.
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = 'mono',
    },

    -- Use LuaSnip to expand snippets, so the custom matlab/cpp snippets
    -- defined in core/snippets.lua keep working
    snippets = { preset = 'luasnip' },

    completion = {
      -- (Default) Only show the documentation popup when manually triggered
      documentation = { auto_show = false },
      menu = {
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
          components = {
            -- Color the source tag per-provider: pink for LSP, blue for buffer.
            -- Highlight groups are defined in plugins/colortheme.lua.
            source_name = {
              width = { max = 30 },
              text = function(ctx) return ctx.source_name end,
              highlight = function(ctx)
                if ctx.source_id == 'lsp' then
                  return 'BlinkCmpSourceLsp'
                elseif ctx.source_id == 'buffer' then
                  return 'BlinkCmpSourceBuffer'
                end
                return 'BlinkCmpSource'
              end,
            },
          },
        },
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      -- By default, blink.cmp registers 'buffer' as a *fallback* of both
      -- 'lsp' and 'path' (only runs when both return 0 items), so with an
      -- attached LSP the buffer source effectively never triggers. Clear
      -- those fallback lists so buffer runs unconditionally alongside them.
      providers = {
        lsp = { fallbacks = {} },
        path = { fallbacks = {} },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- Falls back to the lua implementation if the Rust binary isn't available
    fuzzy = { implementation = 'prefer_rust' },
  },
  opts_extend = { 'sources.default' },
}
