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
  { -- Side-by-side diffs and file history
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git [D]iff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git file [H]istory' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Git diff view [Q]uit' },
    },
  },
  { -- GitHub issues and pull requests inside Neovim (needs the `gh` CLI, logged in)
    'pwntester/octo.nvim',
    cmd = 'Octo',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
    keys = {
      { '<leader>gp', '<cmd>Octo pr list<cr>', desc = 'GitHub [P]ull requests' },
      { '<leader>gi', '<cmd>Octo issue list<cr>', desc = 'GitHub [I]ssues' },
    },
  },
  { -- Highlight merge conflicts and resolve them with shortcuts
    'akinsho/git-conflict.nvim',
    version = '*',
    event = 'BufReadPre',
    opts = {},
  },
}
