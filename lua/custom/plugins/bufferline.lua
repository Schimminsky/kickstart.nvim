-- Leiste mit allen offenen Buffern oben, wie die Datei-Tabs in VS Code
-- https://github.com/akinsho/bufferline.nvim
--
-- <S-h>/<S-l> überschreiben die eingebauten Sprünge H/L (oberste/unterste Bildschirmzeile)
-- <leader>b ist frei gelassen, weil kickstart.plugins.debug es für Breakpoints nutzt
return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Vorheriger Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<CR>', desc = 'Nächster Buffer' },
    -- mini.bufremove schließt den Buffer, ohne das Fenster-Layout (Neo-tree, Splits) zu zerstören
    { '<leader>x', function() require('mini.bufremove').delete(0) end, desc = 'Buffer schließen' },
    { '<leader>X', '<cmd>BufferLineCloseOthers<CR>', desc = 'Alle anderen Buffer schließen' },
  },
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      -- Leiste beginnt rechts vom Neo-tree statt über ihm
      offsets = {
        { filetype = 'neo-tree', text = 'Dateien', highlight = 'Directory', separator = true },
      },
    },
  },
}
