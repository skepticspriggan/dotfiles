-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Jump down while keeping the cursor centered in the middle' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Jump up while keeping the cursor centered in the middle' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Go to next search occurence while keeping the cursor centered in the middle' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Go to previous search occurence while keeping the cursor centered in the middle' })

vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste while preserving clipboard register' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete while preserving clipboard register' })

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy into system clipboard' })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace the current word under the cursor' })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = 'Make current file executable', silent = true })
vim.keymap.set("n", "<leader>cfp", '<cmd>:let @+ = expand("%:p")<CR>', { desc = 'Copy filepath into clipboard', silent = true })
vim.keymap.set("n", "<leader>cfn", '<cmd>:let @+ = expand("%:t")<CR>', { desc = 'Copy filename into clipboard', silent = true })
vim.keymap.set("n", "<leader>crfp", '<cmd>:let @+ = expand("%")<CR>', { desc = 'Copy relative filepath into clipboard', silent = true })
vim.keymap.set("n", "<leader>w", '<cmd>:w<CR>', { desc = 'Write file to disk', silent = true })
vim.keymap.set("n", "J", "mzJ`z", { desc = 'Append line below current line to current line with a space in between'})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move selection down and auto indent' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move selection up and auto indent' })
vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = 'Correct last spell mistake', noremap = true })
vim.keymap.set("n", "<leader>m2p", "<cmd>silent !markdown-to-pdf.sh %<CR>", { desc = 'Convert markdown file to PDF' })
vim.keymap.set("n", "<leader>oe", "<cmd>silent !open-last-export.sh &<CR>", { desc = 'Open last export' })
vim.keymap.set("i", "<C-Del>", "X<Esc>c/\\S<CR>", { desc = 'Delete until next whitespace' })
vim.keymap.set("i", "<C-d>", "X<Esc>c/\\S<CR><Esc>gJi", { desc = 'Delete until and including next whitespace' })
vim.keymap.set("n", "<leader>u", "/\\u<CR>", { desc = 'Move to next upper case letter' })

vim.keymap.set("n", "<leader>gf", function()
  local basename = vim.fn.expand("<cfile>:t:r")
  local directory = vim.fn.expand('%:p:h')
  --local cmd = 'grep -Rl "' .. basename ..'" .config/nvim | head -n 1'
  local cmd = 'find ' .. directory .. ' -type f -name "' .. basename .. '*" | head -n 1'
  --print(cmd)
  local file = io.popen(cmd, "r") -- runs command
  if file == nil then
    return
  end
  local result = file:read("*a") -- read output of command
  result = (string.gsub(result, "%s*$", ""))
  --print(result)
  file:close()
  --local file = "/home/tim/.config/nvim/lua/keymaps.lua"
  vim.cmd({ cmd = 'edit', args = { result }, bang = true })
end, { desc = 'Open nearest file with basename of word under the cursor' })
