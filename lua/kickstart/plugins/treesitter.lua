return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main', -- The rewrite. Needs Neovim 0.11+ and the `tree-sitter` CLI.
    lazy = false, -- The main branch does not support lazy-loading
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'
      ts.setup {}

      -- Parsers to install up front (runs asynchronously, skips ones already installed)
      ts.install { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

      -- Replaces the old `highlight`, `indent`, and `auto_install` options:
      -- on each filetype, install its parser if missing, then turn on highlighting and indent.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end

          local function start()
            if pcall(vim.treesitter.start, args.buf, lang) and lang ~= 'ruby' then
              vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end

          if vim.tbl_contains(ts.get_installed(), lang) then
            start()
          elseif vim.tbl_contains(ts.get_available(), lang) then
            ts.install(lang):await(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                start()
              end
            end)
          end
        end,
      })
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects (use its `main` branch)
  },
}
-- vim: ts=2 sts=2 sw=2 et
