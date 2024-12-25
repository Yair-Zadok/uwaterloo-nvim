----------------------------Leader Key----------------------------
vim.opt.termguicolors = false
vim.opt.signcolumn = "no"
vim.g.mapleader = " "
vim.opt.relativenumber = true
----------------------------Plugins----------------------------

local plugins = {
{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
{'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'},
{'neovim/nvim-lspconfig'},
{'L3MON4D3/LuaSnip'},
{'nvim-treesitter/nvim-treesitter'},
{'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = {'nvim-lua/plenary.nvim'}},
{'mfussenegger/nvim-dap'},
{'nvim-neotest/nvim-nio'},
{'rcarriga/nvim-dap-ui', dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'}},
{'theHamsta/nvim-dap-virtual-text'},
{'akinsho/toggleterm.nvim', version = "*", config = true},
{'glepnir/zephyr-nvim'},
}

local opts = {}

----------------------------Plugin Manager----------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)

----------------------------Plugin Options----------------------------


----------------------------Lsp Zero----------------------------

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

----------------------------Treesitter Highlighting----------------------------

require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = {
    enable = true
  },
}

----------------------------Mason Lsp Manager----------------------------

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
  ensure_installed = { "clangd" },
})

----------------------------Themes----------------------------

--require("zephyr")

----------------------------Dap Debugger----------------------------

require("dapui").setup()
require("nvim-dap-virtual-text").setup({
    show_stop_reason = true,
    only_first_definition = false,
})
require("toggleterm").setup{
    open_mapping = '<Leader>t',
    insert_mappings = false,
    terminal_mappings = true
}

----------------------------Keymaps----------------------------

vim.o.timeoutlen = 155

vim.keymap.set('n', '<Leader>e', ':edit $MYVIMRC<CR>', {})
vim.keymap.set('n', '<Leader>q', ':q<CR>', {})
vim.keymap.set('n', '<Leader>s', ':w<CR>', {})
vim.keymap.set('n', '<Leader>w', ':wq<CR>', {})
vim.keymap.set({'i'}, 'jk', '<Esc>')

--Make tabs 4 spaces
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.opt.colorcolumn = "80"

----------------------------Telescope Keymaps----------------------------

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>f', builtin.find_files, {})
vim.keymap.set('n', '<Leader>l', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<Leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>b', builtin.buffers, {})

local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
})
----------------------------Dap Keymaps----------------------------

local dap = require('dap')
vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<Leader>dc', dap.continue, {})
vim.keymap.set('n', '<Leader>dsi', dap.step_into, {})
vim.keymap.set('n', '<Leader>dso', dap.step_over, {})

vim.keymap.set('n', '<Leader>ui', ":lua require('dapui').open({reset = true})<CR>", {})
vim.keymap.set('n', '<Leader>uc', ":lua require('dapui').close()<CR>", {})

--------------------------------------------------------
