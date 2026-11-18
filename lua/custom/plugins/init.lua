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
  { -- Highlight merge conflicts and resolve them with shortcuts
    'akinsho/git-conflict.nvim',
    version = '*',
    event = 'BufReadPre',
    opts = {},
  },
  { -- Pretty list of diagnostics, references, quickfix, and more
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics (Trouble)' },
      { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix list (Trouble)' },
    },
  },
  { -- A terminal you toggle with one key
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = [[<c-\>]], -- Ctrl-\ opens and closes the terminal
      direction = 'horizontal',
      size = 15,
    },
  },
  { -- Better code folding (collapse functions and classes)
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'VeryLazy',
    init = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99 -- Start with everything unfolded
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require('ufo').setup {
        provider_selector = function()
          return { 'treesitter', 'indent' }
        end,
      }
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    end,
  },
  { -- Prettier Markdown in the buffer
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  { -- Tab-style line along the top showing open files (buffers)
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        offsets = {
          { filetype = 'neo-tree', text = 'Explorer', highlight = 'Directory', separator = true },
        },
      },
    },
    keys = {
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
      { '<leader>bc', '<cmd>bdelete<cr>', desc = '[B]uffer [C]lose' },
      { '<leader>bp', '<cmd>BufferLinePick<cr>', desc = '[B]uffer [P]ick' },
    },
  },
  { -- Status line (replaces mini.statusline)
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'nord',
        icons_enabled = vim.g.have_nerd_font,
        globalstatus = true,
      },
    },
  },
  { -- Add, delete, and change surroundings (replaces mini.surround): ys, ds, cs
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },
  { -- Text objects for functions, classes, and arguments (replaces mini.ai): af/if, ac/ic, aa/ia
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function()
      require('nvim-treesitter-textobjects').setup { select = { lookahead = true } }
      local select = require 'nvim-treesitter-textobjects.select'
      local maps = {
        af = '@function.outer',
        ['if'] = '@function.inner',
        ac = '@class.outer',
        ic = '@class.inner',
        aa = '@parameter.outer',
        ia = '@parameter.inner',
      }
      for lhs, query in pairs(maps) do
        vim.keymap.set({ 'x', 'o' }, lhs, function()
          select.select_textobject(query, 'textobjects')
        end, { desc = 'Select ' .. query })
      end
    end,
  },
}
