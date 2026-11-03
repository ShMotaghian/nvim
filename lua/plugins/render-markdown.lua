return { -- Render markdown headers, bullets, checkboxes, code blocks, tables nicely in-buffer
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown' },
  opts = {
    -- Completions for checkboxes and callouts (> [!NOTE] etc.) via an in-process LSP,
    -- so they show up in blink.cmp alongside marksman's link/heading completions
    completions = { lsp = { enabled = true } },
    -- Keep the sign column free for gitsigns/diagnostics
    heading = { sign = false },
    -- Draw code blocks as a box sized to their content instead of full window width
    code = { sign = false, width = 'block', right_pad = 1 },
  },
  keys = {
    { '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', ft = 'markdown', desc = '[M]arkdown [R]ender toggle' },
  },
}
