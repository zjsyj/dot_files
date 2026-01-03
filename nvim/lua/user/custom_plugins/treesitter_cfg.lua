local M = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
   -- event = {'LazyFile', 'VeryLazy'},
    event = 'VeryLazy',
}
return M
