-- Strukturelles Editieren für Clojure (Paredit): Klammern bleiben immer ausgeglichen,
-- Code wird als Ausdrücke (Forms) statt als Text bearbeitet.
-- https://github.com/julienvincent/nvim-paredit
--
-- Wichtigste Tasten (Normal-Modus):
--   >)  <(   Slurp: nächsten/vorherigen Ausdruck in die aktuelle Klammer ziehen
--   <)  >(   Barf: letzten/ersten Ausdruck aus der Klammer herausschieben
--   >e  <e   Element nach rechts/links verschieben
--   >f  <f   ganze Form nach rechts/links verschieben
--   E  W  B  gE   zum Ende/Anfang des nächsten/vorherigen Elements springen
--   af if    Textobjekte „ganze Form“ / „Inhalt der Form“ (z. B. `daf`, `cif`, `yaf`)
--   aF iF    wie af/if, aber die äußerste Form (Top-Level)
--   ae ie    Textobjekt „Element“
-- Alle Tasten: `:help nvim-paredit` bzw. README im Repo.
--
-- Raise und Splice lägen standardmäßig auf <localleader>o/O/@, also auf der Leertaste
-- und damit mitten in den <leader>-Mappings. Deshalb liegen sie hier auf dem Conjure-Präfix `,`:
--   ,o  Form anheben (ersetzt die Eltern-Form durch die aktuelle Form)
--   ,O  Element anheben
--   ,@  Klammern um die aktuelle Form entfernen (Splice)
return {
  'julienvincent/nvim-paredit',
  ft = { 'clojure' },
  config = function()
    local paredit = require 'nvim-paredit'
    paredit.setup {
      keys = {
        ['<localleader>o'] = false,
        ['<localleader>O'] = false,
        ['<localleader>@'] = false,
        [',o'] = { paredit.api.raise_form, 'Raise form' },
        [',O'] = { paredit.api.raise_element, 'Raise element' },
        [',@'] = { paredit.api.unwrap_form_under_cursor, 'Splice sexp' },
      },
    }
  end,
}
