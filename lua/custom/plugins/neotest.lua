-- Tests im Editor: ausführen, Ergebnisse als Zeichen neben dem Code, Übersicht als Seitenleiste
-- https://github.com/nvim-neotest/neotest
--
-- Adapter: Python (pytest). Java-Tests laufen über nvim-jdtls (<leader>jt); neotest-java bräuchte Maven oder Gradle.
-- Erkennt Tests über Treesitter, die Parser (python, ...) stehen in der init.lua.
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
  },
  keys = {
    { '<leader>nn', function() require('neotest').run.run() end, desc = 'Test unter Cursor ([N]earest)' },
    { '<leader>nf', function() require('neotest').run.run(vim.fn.expand '%') end, desc = 'Tests der [F]ile' },
    { '<leader>na', function() require('neotest').run.run(vim.uv.cwd()) end, desc = '[A]lle Tests im Projekt' },
    { '<leader>nl', function() require('neotest').run.run_last() end, desc = '[L]etzten Testlauf wiederholen' },
    { '<leader>nd', function() require('neotest').run.run { strategy = 'dap' } end, desc = 'Test unter Cursor [D]ebuggen' },
    { '<leader>nx', function() require('neotest').run.stop() end, desc = 'Testlauf stoppen' },
    { '<leader>ns', function() require('neotest').summary.toggle() end, desc = '[S]ummary (Testbaum) ein/aus' },
    { '<leader>no', function() require('neotest').output.open { enter = true, auto_close = true } end, desc = '[O]utput des Tests unter Cursor' },
    { '<leader>nO', function() require('neotest').output_panel.toggle() end, desc = '[O]utput-Panel ein/aus' },
    { '<leader>nw', function() require('neotest').watch.toggle(vim.fn.expand '%') end, desc = '[W]atch: Tests der Datei bei jedem Speichern' },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          runner = 'pytest',
          -- Breakpoints auch in Bibliotheken, nicht nur im eigenen Code
          dap = { justMyCode = false },
        },
      },
      -- Fehlschläge zusätzlich als Diagnostics (tauchen dann auch in Trouble auf)
      diagnostic = { enabled = true },
      status = { virtual_text = false, signs = true },
      output = { open_on_run = false },
    }
  end,
}
