vim.o.showtabline = 2
--vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'

require('lualine').setup{options = {theme = require'lualine.themes.gruvbox'}}
require('ibl').setup()
require('glow').setup()

vim.opt.sessionoptions = { -- required
    "buffers",
    "tabpages",
    "globals",
}
require("scope").setup({})

