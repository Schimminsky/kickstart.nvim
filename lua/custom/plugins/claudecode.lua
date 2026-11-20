-- Claude Code in Neovim: Terminal als Split, Auswahl/Dateien senden, Änderungen als Diff prüfen
-- https://github.com/coder/claudecode.nvim
return {
  'coder/claudecode.nvim',
  cmd = { 'ClaudeCode', 'ClaudeCodeFocus', 'ClaudeCodeSend', 'ClaudeCodeAdd', 'ClaudeCodeStatus' },
  keys = {
    { '<leader>ac', '<cmd>ClaudeCode<CR>', desc = '[A]I: [C]laude ein/aus' },
    { '<leader>af', '<cmd>ClaudeCodeFocus<CR>', desc = '[A]I: Claude [F]okussieren' },
    { '<leader>ar', '<cmd>ClaudeCode --resume<CR>', desc = '[A]I: Sitzung fortsetzen ([R]esume)' },
    { '<leader>am', '<cmd>ClaudeCodeSelectModel<CR>', desc = '[A]I: [M]odell wählen' },
    { '<leader>ab', '<cmd>ClaudeCodeAdd %<CR>', desc = '[A]I: aktuellen [B]uffer hinzufügen' },
    { '<leader>as', '<cmd>ClaudeCodeSend<CR>', mode = 'v', desc = '[A]I: Auswahl [S]enden' },
    { '<leader>as', '<cmd>ClaudeCodeTreeAdd<CR>', ft = 'neo-tree', desc = '[A]I: Datei aus dem Baum [S]enden' },
    { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<CR>', desc = '[A]I: Diff [A]nnehmen' },
    { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<CR>', desc = '[A]I: [D]iff ablehnen' },
  },
  opts = {
    terminal = {
      provider = 'native', -- eingebautes :terminal, kein snacks.nvim nötig
      split_side = 'right',
      split_width_percentage = 0.35,
    },
  },
}
