-- Fehler und Warnungen als dauerhaft offenes Panel, wie "Problems" in VS Code
-- https://github.com/folke/trouble.nvim
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    { '<leader>tp', '<cmd>Trouble diagnostics toggle<CR>', desc = '[T]oggle [P]roblems (Trouble)' },
  },
  opts = {},
}
