-- Lazygit in einem Floating-Fenster (nutzt das systemweit installierte `lazygit`)
-- https://github.com/kdheepak/lazygit.nvim
return {
  'kdheepak/lazygit.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'LazyGit', 'LazyGitCurrentFile', 'LazyGitLog' },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<CR>', desc = '[G]it Lazy[G]it' },
    { '<leader>gl', '<cmd>LazyGitLog<CR>', desc = '[G]it [L]og (Lazygit)' },
  },
}
