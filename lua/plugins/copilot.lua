return { -- GitHub Copilot inline suggestions (ghost text)
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    suggestion = {
      -- Show suggestions automatically as you type
      auto_trigger = true,
      -- Insert-mode keymaps (<C-l> is only mapped in normal mode elsewhere, so it's free here)
      keymap = {
        accept = '<C-l>', -- accept whole suggestion
        accept_line = '<A-l>', -- accept one line
        accept_word = '<A-w>', -- accept one word
        next = '<A-]>', -- next suggestion
        prev = '<A-[>', -- previous suggestion
        dismiss = '<A-e>',
      },
    },
    -- The side panel duplicates the ghost text; keep things minimal
    panel = { enabled = false },
  },
}
