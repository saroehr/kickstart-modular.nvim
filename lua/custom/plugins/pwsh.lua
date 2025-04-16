return {
  {
    'TheLeoP/powershell.nvim',
    enabled = OS_NAME == OS_WINDOWS,
    ---@type powershell.user_config
    opts = {
      bundle_path = vim.fn.stdpath 'data' .. '/mason/packages/powershell-editor-services',
    },
  },
}
