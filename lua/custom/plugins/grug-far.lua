-- Projektweites Suchen & Ersetzen (ripgrep), mit Vorschau aller Treffer in einem Buffer
-- https://github.com/MagicDuck/grug-far.nvim
return {
  'MagicDuck/grug-far.nvim',
  cmd = 'GrugFar',
  opts = {},
  keys = {
    { '<leader>sR', function() require('grug-far').open() end, desc = '[S]earch & [R]eplace (projektweit)' },
    {
      '<leader>sR',
      function() require('grug-far').with_visual_selection() end,
      mode = 'v',
      desc = '[S]earch & [R]eplace mit Auswahl',
    },
    {
      '<leader>sF',
      function() require('grug-far').open { prefills = { paths = vim.fn.expand '%' } } end,
      desc = '[S]earch & Replace nur in dieser [F]ile',
    },
  },
}
