-- set <space> as the leader key before plugins are loaded since wrong keymaps will be created otherwise
-- see `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- install plugin manager
require 'lazy-bootstrap'

-- configure plugins
require 'lazy-plugins'

require 'options'

require 'keymaps'

require 'globals'

require 'auto-commands'
