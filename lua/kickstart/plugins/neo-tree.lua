-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  -- Baum beim Start immer öffnen (Cursor bleibt im Code), außer bei Commit-Nachrichten, Diffs und Man-Seiten
  init = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('neo-tree-autostart', { clear = true }),
      callback = function()
        if vim.o.diff or vim.bo.buftype ~= '' or vim.bo.filetype:match '^git' or vim.bo.filetype == 'man' then return end
        vim.cmd 'Neotree show'
      end,
    })
  end,
  opts = {
    -- Sonst bleibt nach `:q` im letzten Code-Fenster nur der Baum übrig
    close_if_last_window = true,
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
