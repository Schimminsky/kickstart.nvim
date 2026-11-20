-- Obsidian-Vault in Neovim: Wikilinks, Backlinks, Suche, Daily Notes
-- https://github.com/obsidian-nvim/obsidian.nvim
--
-- Bewusst NICHT aktiv:
--  - Frontmatter-Verwaltung: würde Frontmatter beim Speichern umschreiben und mit Media DB,
--    dem Obsidian-Linter und steam_sync.py kollidieren
--  - Templates: die Vault-Templates sind Templater-Syntax (<% tp.* %>) und laufen hier nicht
local vault = vim.fn.expand '~/obsidian/notes'

return {
  'obsidian-nvim/obsidian.nvim',
  -- Nur laden, wenn der Vault auf diesem Rechner existiert
  cond = vim.fn.isdirectory(vault) == 1,
  version = '*',
  ft = 'markdown',
  cmd = 'Obsidian',
  keys = {
    { '<leader>od', '<cmd>Obsidian today<CR>', desc = '[O]bsidian [D]aily Note (heute)' },
    { '<leader>oo', '<cmd>Obsidian quick_switch<CR>', desc = '[O]bsidian Notiz [O]effnen' },
    { '<leader>os', '<cmd>Obsidian search<CR>', desc = '[O]bsidian [S]uche' },
    { '<leader>ot', '<cmd>Obsidian tags<CR>', desc = '[O]bsidian [T]ags' },
    { '<leader>ob', '<cmd>Obsidian backlinks<CR>', desc = '[O]bsidian [B]acklinks' },
    { '<leader>on', '<cmd>Obsidian new<CR>', desc = '[O]bsidian [N]eue Notiz (Inbox)' },
    { '<leader>oc', '<cmd>Obsidian toggle_checkbox<CR>', desc = '[O]bsidian [C]heckbox umschalten' },
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      { name = 'notes', path = vault },
    },

    frontmatter = { enabled = false },
    templates = { enabled = false },

    -- 06 - Journal/2026/2026-10-19.md
    daily_notes = {
      folder = '06 - Journal',
      date_format = 'YYYY/YYYY-MM-DD',
    },

    -- Neue Notizen landen in der Inbox, Dateiname = Titel (wie in Obsidian)
    notes_subdir = '00 - Inbox',
    new_notes_location = 'notes_subdir',
    note_id_func = function(title) return title or tostring(os.time()) end,

    picker = { name = 'telescope.nvim' },

    -- Darstellung übernimmt render-markdown.nvim
    ui = { enable = false },
  },
}
