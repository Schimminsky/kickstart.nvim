-- Sessions: offene Dateien, Fenster und Splits pro Projektverzeichnis speichern und wiederherstellen
-- https://github.com/folke/persistence.nvim
return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- erst laden, wenn eine Datei geöffnet wird; speichert dann automatisch beim Beenden
  opts = {},
  keys = {
    { '<leader>ps', function() require('persistence').load() end, desc = '[P]roject [S]ession wiederherstellen (aktuelles Verzeichnis)' },
    { '<leader>pS', function() require('persistence').select() end, desc = '[P]roject [S]ession auswählen' },
    { '<leader>pl', function() require('persistence').load { last = true } end, desc = '[P]roject [L]etzte Session' },
    { '<leader>pd', function() require('persistence').stop() end, desc = '[P]roject Session beim Beenden [D]iesmal nicht speichern' },
  },
  init = function()
    -- Neo-tree vor dem Speichern schließen, sonst landet ein leeres Baum-Fenster in der Session
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      group = vim.api.nvim_create_augroup('persistence-neotree', { clear = true }),
      callback = function() pcall(vim.cmd, 'Neotree close') end,
    })
  end,
}
