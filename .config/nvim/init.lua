-- Set leader key
vim.g.mapleader = ","

-- Autocomplete selection with Enter
vim.api.nvim_set_keymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : \"\\<CR>\"", { expr = true, silent = true })

-- Plugins using Packer
require('packer').startup(function(use)
  use 'ibhagwan/fzf-lua'                   -- FZF Alternative
  use 'rebelot/kanagawa.nvim'               -- Kanagawa theme
  use 'kdheepak/lazygit.nvim'               -- Git integration
  use 'psliwka/vim-smoothie'                -- Smooth scrolling
  use 'tpope/vim-fugitive'                  -- Git wrapper
  use { 'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps' } -- File explorer
  use 'neoclide/coc.nvim'                   -- Autocomplete & LSP
  use 'vimwiki/vimwiki'                     -- Vimwiki
  use 'lumiliet/vim-twig'                   -- Twig support
  use 'peitalin/vim-jsx-typescript'         -- JSX/TSX support
  use 'pangloss/vim-javascript'             -- JavaScript support
  use 'leafgarland/typescript-vim'          -- TypeScript support
  use 'jparise/vim-graphql'                 -- GraphQL syntax support
  use 'jwalton512/vim-blade'                -- Laravel Blade syntax
  use 'mfussenegger/nvim-dap'               -- Debugging Adapter Protocol
end)

-- General settings
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.scrolloff = 10
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.background = "dark"
vim.o.guifont = "Inconsolata,monospace,Hack:h15"
-- vim.cmd("colorscheme kanagawa-wave")
-- vim.cmd("colorscheme koehler")
vim.cmd("colorscheme industry")

-- Neovide settings (if using)
vim.g.neovide_scale_factor = 0.6
vim.g.neovide_transparency = 0.8
vim.g.neovide_background_color = "#000000"
vim.g.neovide_refresh_rate = 60
vim.g.neovide_disable_ligatures = true
vim.g.neovide_input_use_logo = true

vim.api.nvim_set_keymap('n', '<C-S-v>', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-v>', '"+p', { noremap = true, silent = true })

-- Function to open fzf-lua and paste clipboard content
local function fzf_paste_command(cmd)
  local clipboard = vim.fn.getreg("+") -- Get system clipboard content

  -- Open fzf-lua
  require("fzf-lua")[cmd]()

  -- Wait a bit and then insert clipboard content
  vim.schedule(function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(clipboard, true, false, true), "i", true)
  end)
end

-- Set the function globally to prevent "nil" error
_G.fzf_paste_command = fzf_paste_command

-- Keybindings for opening fzf and auto-pasting clipboard
vim.api.nvim_set_keymap("n", "<C-S-x>", "<cmd>lua _G.fzf_paste_command('files')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-f>", "<cmd>lua _G.fzf_paste_command('live_grep')<CR>", { noremap = true, silent = true })

-- PHP settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  command = "setlocal tabstop=4 shiftwidth=4 expandtab"
})

-- Laravel Blade support
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.blade.php",
  command = "set filetype=blade"
})

-- Twig filetype detection
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.twig",
  command = "set filetype=twig"
})

-- React & Node.js settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  command = "setlocal tabstop=2 shiftwidth=2 expandtab"
})

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
      horizontal = "right:70%",
      wrap = "nowrap",  -- Prevents text wrapping in preview
      hidden = "nohidden", -- Ensures preview stays visible
    },
  },
  files = {
    fd_opts = "--type f --hidden --exclude .git --exclude node_modules",
  },
  grep = {
    rg_opts = "--fixed-strings --ignore-case --hidden --glob '!.git/*' --glob '!node_modules/*'",
    silent = true,
  }
})

-- LSP Setup (Coc Extensions)
vim.g.coc_global_extensions = {
  'coc-json',
  'coc-tsserver',
  'coc-html',
  'coc-css',
  'coc-phpls',
  'coc-vetur',
  'coc-emmet',
  'coc-eslint',
  'coc-prettier'
}

-- CHADTree Toggle
vim.api.nvim_set_keymap("n", "<leader>n", ":CHADopen<CR>", { noremap = true, silent = true })

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
vim.api.nvim_set_keymap("n", "<C-f>", ":FzfLua live_grep<CR>", { noremap = true, silent = true })

-- Save file shortcuts
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<Esc>:w<CR>gv", { noremap = true, silent = true })

-- Move lines up and down
vim.api.nvim_set_keymap("n", "<C-k>", ":m-2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":m+<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<Esc>:m-2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<Esc>:m+<CR>", { noremap = true, silent = true })

-- Disable auto comment on next line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "set formatoptions-=cro"
})

-- Auto-create directory if it does not exist before saving a file
vim.api.nvim_create_augroup("vimrc_auto_mkdir", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = "vimrc_auto_mkdir",
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      local choice = vim.fn.input("'" .. dir .. "' does not exist. Create? [y/N] ")
      if choice:match("^y") then
        vim.fn.mkdir(dir, "p")
      end
    end
  end
})
