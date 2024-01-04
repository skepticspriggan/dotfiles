return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    vim.keymap.set('n', '<leader>m', require("harpoon.mark").add_file, { desc = '[H]arpoon [M]ark' })
    vim.keymap.set('n', '<leader>ht', require("harpoon.ui").toggle_quick_menu, { desc = '[H]arpoon [T]oggle Quick Menu' })
    vim.keymap.set('n', '<C-j>', --'<leader>1'
      function() require("harpoon.ui").nav_file(1) end,
      { desc = '[H]arpoon navigate to mark [1]' }
    )
    vim.keymap.set('n', '<C-k>', --'<leader>2'
      function() require("harpoon.ui").nav_file(2) end,
      { desc = '[H]arpoon navigate to mark [2]' }
    )
    vim.keymap.set('n', '<C-h>', --'<leader>3'
      function() require("harpoon.ui").nav_file(3) end,
      { desc = '[H]arpoon navigate to mark [3]' }
    )
    vim.keymap.set('n', '<C-n>', --'<leader>4'
      function() require("harpoon.ui").nav_file(4) end,
      { desc = '[H]arpoon navigate to mark [4]' }
    )
  end,
}
