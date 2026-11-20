-- Clojure-REPL im Editor: Code direkt aus dem Buffer auswerten, Ergebnis im Log und als Inline-Text
-- https://github.com/Olical/conjure
--
-- Verbindung: Liegt im Projekt eine `.nrepl-port` (z. B. von `lein repl`), verbindet sich Conjure automatisch.
-- Sonst startet es selbst eine babashka-REPL (gut für Skripte und Koans, ohne Projekt-Abhängigkeiten).
-- Alle Tasten beginnen mit `,` — Übersicht mit `:help conjure-mappings`.
return {
  'Olical/conjure',
  ft = { 'clojure' },
  init = function()
    -- Nur für Clojure. Standardmäßig hängt sich Conjure auch an Python, Lua, Rust und andere Sprachen.
    vim.g['conjure#filetypes'] = { 'clojure' }
    -- Eigener Präfix statt <localleader>: Die Leertaste ist Leader und Localleader zugleich,
    -- Conjure würde in Clojure-Dateien sonst <leader>s…, <leader>t…, <leader>e überdecken.
    vim.g['conjure#mapping#prefix'] = ','
    -- `K` und `gd` bleiben bei clojure-lsp (funktionieren auch ohne laufende REPL)
    vim.g['conjure#mapping#doc_word'] = false
    vim.g['conjure#mapping#def_word'] = false
  end,
}
