return {

  'shaunsingh/nord.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- Example config in lua
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = true
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false

    -- Load the colorscheme
    require('nord').set()

    -- blink.cmp source-tag colors: pink for LSP, blue for buffer.
    -- Re-applied on every ColorScheme event since `:colorscheme nord`
    -- (e.g. from the transparency toggle below) wipes custom highlights.
    local function set_blink_source_highlights()
      vim.api.nvim_set_hl(0, 'BlinkCmpSourceLsp', { fg = '#B48EAD' }) -- nord15
      vim.api.nvim_set_hl(0, 'BlinkCmpSourceBuffer', { fg = '#81A1C1' }) -- nord9
    end
    set_blink_source_highlights()
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = 'nord',
      callback = set_blink_source_highlights,
    })

    -- Toggle background transparency
    local bg_transparent = true

    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      vim.g.nord_disable_background = bg_transparent
      vim.cmd [[colorscheme nord]]
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}
