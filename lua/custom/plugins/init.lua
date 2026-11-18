-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { -- Nord colorscheme (needs true color, so `termguicolors` must be on)
    'gbprod/nord.nvim',
    lazy = false,
    priority = 1000, -- Load before other plugins
    config = function()
      require('nord').setup {}
      vim.cmd.colorscheme 'nord'
    end,
  },
  { -- Lazygit inside a floating Neovim window (needs the `lazygit` CLI installed)
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Lazy[G]it' },
    },
  },
}
