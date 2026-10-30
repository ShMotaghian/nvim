vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldnestmax = 3
vim.opt.foldlevelstart = 2

vim.api.nvim_set_hl(0, 'Folded', { fg = '#2e8b57', bg = '#1a1b26' })
vim.opt.foldenable = true

