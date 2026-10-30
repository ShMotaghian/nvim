return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  -- Pinned to the legacy `master` branch, which keeps the old configs.lua/opts
  -- API this file uses. The default branch moved to `main`, a rewrite that
  -- dropped that API (ensure_installed/highlight.enable/indent.enable) entirely.
  branch = 'master',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
      'lua',
      'python',

      'matlab',

      'vimdoc',
      'vim',
      'regex',

      'dockerfile',
      'toml',
      'json',
      'java',
      'groovy',
      'go',
      'gitignore',
      'yaml',
      'make',
      'cmake',
      'cpp',
      'markdown',
      'markdown_inline',
      'tsx',
      'html',
      'bibtex',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
      disable = { 'markdown', 'markdown_inline' },
    },
    -- c/cpp disabled: nvim-treesitter's indent query predicate handler
    -- (query_predicates.lua) errors on this Neovim version for common C++
    -- constructs, causing inconsistent/wrong indent on <CR>. Falls back to
    -- Neovim's built-in cindent engine instead, which handles C++ correctly.
    indent = { enable = true, disable = { 'ruby', 'c', 'cpp' } },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
