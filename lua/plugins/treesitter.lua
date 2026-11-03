return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  -- Pinned to the legacy `master` branch, which keeps the old configs.lua/opts
  -- API this file uses. The default branch moved to `main`, a rewrite that
  -- dropped that API (ensure_installed/highlight.enable/indent.enable) entirely.
  branch = 'master',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  -- Compatibility shim: the `master` branch registers its query predicates and
  -- directives (set-lang-from-info-string!, downcase!, is?, ...) with `all = false`,
  -- expecting one node per capture. Neovim 0.12 dropped that option and always
  -- passes a list of nodes, so they crash with "attempt to call method 'range'"
  -- (e.g. on markdown code fences). Hand those handlers a single node again.
  init = function()
    local query = vim.treesitter.query
    for _, name in ipairs { 'add_predicate', 'add_directive' } do
      local orig = query[name]
      query[name] = function(n, handler, opts)
        if type(opts) == 'table' and opts.all == false then
          local h = handler
          handler = function(match, ...)
            local single = {}
            for id, nodes in pairs(match) do
              single[id] = type(nodes) == 'table' and nodes[#nodes] or nodes
            end
            return h(single, ...)
          end
        end
        return orig(n, handler, opts)
      end
    end
  end,
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
