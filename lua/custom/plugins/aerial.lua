-- Code-Outline: Funktionen, Klassen, Überschriften der aktuellen Datei als Seitenleiste
-- https://github.com/stevearc/aerial.nvim
return {
  'stevearc/aerial.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  cmd = { 'AerialToggle', 'AerialNavToggle' },
  opts = {
    backends = { 'lsp', 'treesitter', 'markdown', 'man' },
    layout = { default_direction = 'right', min_width = 28 },
    show_guides = true,
    -- Outline folgt dem Cursor im Code
    highlight_on_hover = true,
    autojump = false,
  },
  keys = {
    { '<leader>to', '<cmd>AerialToggle!<CR>', desc = '[T]oggle [O]utline (Aerial)' },
    { '<leader>tO', '<cmd>AerialNavToggle<CR>', desc = '[T]oggle [O]utline als Popup-Navigation' },
  },
}
