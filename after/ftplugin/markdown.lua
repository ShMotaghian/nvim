-- Prose-friendly settings for markdown buffers
vim.opt_local.wrap = true -- soft-wrap long lines (global default is nowrap)
vim.opt_local.linebreak = true -- wrap at word boundaries
vim.opt_local.breakindent = true -- keep wrapped list items indented

-- Move by screen line when lines are wrapped (counts like 5j still jump by file lines)
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { buffer = true, expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { buffer = true, expr = true })
