-- simple plug and play plugins that require no configuration
require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-unimpaired',
  'vim-pandoc/vim-pandoc-syntax',
  -- show pending keybinds
  { 'folke/which-key.nvim',  opts = {} },
  -- comment visual regions/lines with `gc`
  { 'numToStr/Comment.nvim', opts = {} },
  'nvim-treesitter/nvim-treesitter-context',

  { import = 'plugins' },
}, {})
