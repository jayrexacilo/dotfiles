-- Set leader key
vim.g.mapleader = ","

-- Autocomplete selection with Enter
vim.api.nvim_set_keymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : \"\\<CR>\"", { expr = true, silent = true })

-- Plugins using Packer
require('packer').startup(function(use)
  use 'ibhagwan/fzf-lua'                   -- FZF Alternative
  use 'tek256/simple-dark'                  -- Theme
  use 'rebelot/kanagawa.nvim'               -- Kanagawa theme
  use 'kdheepak/lazygit.nvim'               -- Git integration
  use 'psliwka/vim-smoothie'                -- Smooth scrolling
  use 'tpope/vim-fugitive'                  -- Git wrapper
  use { 'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps' } -- File explorer
  use 'mkitt/tabline.vim'                   -- Tabline
  use 'vimwiki/vimwiki'                     -- Vimwiki
  use 'lumiliet/vim-twig'                   -- Twig support
end)

-- General settings
vim.o.clipboard = "unnamedplus"
vim.o.ttimeout = true
vim.o.ttimeoutlen = 100
vim.o.timeoutlen = 200
vim.o.mouse = "a"
vim.o.backspace = "indent,eol,start"
vim.o.scrolloff = 20
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.showmatch = true
vim.o.autoindent = true

-- Disable backup files
vim.o.undofile = false
vim.o.swapfile = false
vim.o.backup = false

-- Appearance
vim.o.shortmess = vim.o.shortmess .. "I"
vim.o.laststatus = 2
vim.o.showtabline = 2
vim.o.hlsearch = true
vim.o.background = "dark"
vim.cmd("colorscheme kanagawa-dragon")
vim.cmd("set stl=%{expand('%:~:.')}")

-- Neovide settings (if using)
vim.g.neovide_scale_factor = 0.6
vim.g.neovide_transparency = 0.9

-- PHP tab width
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  command = "setlocal tabstop=4 shiftwidth=4 expandtab"
})

-- Twig filetype detection
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.twig",
  command = "set filetype=twig"
})

-- File explorer (CHADTree)
vim.api.nvim_set_keymap("n", "<leader>n", ":CHADopen<CR>", { noremap = true, silent = true })

-- FZF-Lua Configuration
require('fzf-lua').setup({
  winopts = {
    height = 0.3,
    width  = 1.0,
    row    = 1,
    col    = 0.0,
    border = "rounded",
    preview = {
      layout = "horizontal",
      horizontal = "right:70%"
    },
  },
  grep = {
    rg_opts = "--fixed-strings --ignore-case --hidden",
    silent = true,
  }
})

-- LazyGit mapping
vim.api.nvim_set_keymap("n", "<leader>l", ":LazyGit<CR>", { noremap = true, silent = true })

-- Toggle Line Numbers
function LineNumberToggle()
  if vim.o.relativenumber then
    vim.o.relativenumber = false
    vim.o.number = false
  else
    vim.o.relativenumber = true
    vim.o.number = true
  end
end
vim.api.nvim_set_keymap("n", "<C-l>", ":lua LineNumberToggle()<CR>", { noremap = true, silent = true })

-- Keybindings
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":bn<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", ":bp<CR>", { noremap = true, silent = true })

-- FZF Keybindings
vim.api.nvim_set_keymap("n", "<C-x>", ":FzfLua files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>", ":FzfLua buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-f>", ":FzfLua live_grep_resume<CR>", { noremap = true, silent = true })

-- Save file shortcuts
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<Esc>:w<CR>gv", { noremap = true, silent = true })

-- Move lines up and down
vim.api.nvim_set_keymap("n", "<C-k>", ":m-2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":m+<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<Esc>:m-2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<Esc>:m+<CR>", { noremap = true, silent = true })

-- Prettier command
vim.cmd([[ command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile') ]])

-- Disable auto comment on next line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "set formatoptions-=cro"
})

-- Auto-create directories if they don't exist
vim.api.nvim_create_augroup("vimrc-auto-mkdir", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "vimrc-auto-mkdir",
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if not vim.fn.isdirectory(dir) then
      vim.fn.mkdir(dir, "p")
    end
  end
})
