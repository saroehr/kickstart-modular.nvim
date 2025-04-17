-- https://github.com/anuvyklack/help-vsplit.nvim
return {
  {
    'anuvyklack/help-vsplit.nvim',
    config = function()
      require('help-vsplit').setup {
        always = true, -- always open help in a vertical split.
      }
    end,
  },
}
