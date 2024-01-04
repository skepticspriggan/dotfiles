-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- install plugin manager
require 'lazy-bootstrap'

-- configure plugins
require 'lazy-plugins'

-- set options
require 'options'

-- set keymaps
require 'keymaps'

-- configure fuzzy finder
require 'telescope-setup'

-- configure syntax parser for highlighting
require 'treesitter-setup'

-- configure LSP for navigating to definitions, searching docs etc.
require 'lsp-setup'

-- configure auto completion
require 'cmp-setup'

-- configure citation auto complete
require 'pandoc-setup'

-- load global functions
require 'globals'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
