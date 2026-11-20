-- GitHub Copilot: Vorschläge als grauer Text beim Tippen
-- https://github.com/github/copilot.vim
--
-- Einmalig anmelden: `:Copilot setup`
return {
  'github/copilot.vim',
  event = 'InsertEnter',
  cmd = 'Copilot',
  init = function()
    -- <Tab> bleibt frei für das Springen in Snippets (blink.cmp); angenommen wird mit <C-l>
    vim.g.copilot_no_tab_map = true

    -- Notizen (Journal etc.) gehen nicht an Copilot; Markdown wäre sonst standardmäßig aktiv
    vim.g.copilot_filetypes = { markdown = false }

    -- .env-Dateien enthalten Zugangsdaten (z.B. steam_sync.env), Copilot wäre dort sonst aktiv
    vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
      group = vim.api.nvim_create_augroup('copilot-no-secrets', { clear = true }),
      pattern = { '*.env', '.env', '.env.*' },
      callback = function(event) vim.b[event.buf].copilot_enabled = false end,
    })
  end,
  config = function()
    vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, desc = 'Copilot: Vorschlag annehmen' })
    vim.keymap.set('i', '<M-n>', '<Plug>(copilot-next)', { desc = 'Copilot: nächster Vorschlag' })
    vim.keymap.set('i', '<M-p>', '<Plug>(copilot-previous)', { desc = 'Copilot: vorheriger Vorschlag' })
    vim.keymap.set('i', '<M-e>', '<Plug>(copilot-dismiss)', { desc = 'Copilot: Vorschlag verwerfen' })
  end,
}
