return {
  "catppuccin/nvim",
  name = "catpuccin",
  enabled = true,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "catppuccin"
  end,
}
