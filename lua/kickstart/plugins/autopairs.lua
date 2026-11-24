-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
  config = function(_, opts)
    local npairs = require 'nvim-autopairs'
    npairs.setup(opts)
    -- In Clojure sind ' (quote) und ` (syntax-quote) keine Paare: '(1 2) soll nicht zu ''(1 2) werden
    for _, char in ipairs { "'", '`' } do
      for _, rule in ipairs(npairs.get_rules(char)) do
        if not rule.filetypes then rule.not_filetypes = vim.list_extend(rule.not_filetypes or {}, { 'clojure' }) end
      end
    end
    -- setup() hat die Regeln für den aktuellen Buffer schon festgelegt, daher neu anwenden
    npairs.force_attach()
  end,
}
