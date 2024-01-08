-- simple plug and play plugins that require no configuration
require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-unimpaired',
  -- show pending keybinds
  { 'folke/which-key.nvim',  opts = {} },
  -- comment visual regions/lines with `gc`
  { 'numToStr/Comment.nvim', opts = {} },
  'nvim-treesitter/nvim-treesitter-context',

  { import = 'plugins' },
}, {
  dev = {
    path = "~/.config/nvim/scratch",
  }
})
