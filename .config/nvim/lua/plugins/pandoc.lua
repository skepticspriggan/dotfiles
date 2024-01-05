-- configure citation auto complete
return {
  'vim-pandoc/vim-pandoc',
  event = "BufEnter *.md",
  config = function()
    vim.cmd("let g:pandoc#modules#disabled = ['folding']")
    --vim.cmd("let g:pandoc#modules#enabled = ['command', 'bibliographies']")
    vim.cmd("let g:pandoc#biblio#sources = 'l'")
    vim.cmd("let g:pandoc#biblio#use_bibtool = 1")
    vim.cmd("let g:pandoc#completion#bib#mode = 'citeproc'")
    vim.cmd("let g:pandoc#spell#enabled = 0")
    vim.cmd("set omnifunc=syntaxcomplete#Complete")
  end
}
