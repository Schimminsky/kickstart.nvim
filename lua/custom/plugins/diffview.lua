-- Diffs und Merge-Konflikte in einer eigenen Ansicht
-- https://github.com/sindrets/diffview.nvim
return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = '[G]it [D]iffview öffnen' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = '[G]it [H]istorie der Datei' },
    { '<leader>gc', '<cmd>DiffviewClose<CR>', desc = '[G]it Diffview [C]lose' },
  },
}
