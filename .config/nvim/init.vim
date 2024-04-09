" I use this FZF plugin to swap between buffers & files heavily
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tek256/simple-dark'
  Plug 'mattn/emmet-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'kdheepak/lazygit.nvim'
  Plug 'psliwka/vim-smoothie'
  Plug 'tpope/vim-fugitive'
  Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
  Plug 'mkitt/tabline.vim'
  "Plug 'ap/vim-css-color'
call plug#end()


set clipboard=unnamedplus
set ttimeout
set ttimeoutlen=100
set timeoutlen=200
" General configurations
"set ttymouse=sgr
set mouse=a
set backspace=indent,eol,start
"set scrolloff=30
set number relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set showmatch
set autoindent
" No temporary files
set noundofile
set noswapfile
set nobackup
" Visual apperance
set shortmess+=I
"set statusline=%F
set stl=%{expand('%:~:.')}
set laststatus=2
set showtabline=2
set background=dark
set hlsearch
set guifont=Hack:h12
let g:neovide_scale_factor = 0.6
let g:neovide_transparency = 0.9
colorscheme habamax
hi Search cterm=reverse ctermfg=White ctermbg=Black



let mapleader =","
let g:netrw_liststyle=3
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_preview_window = ''

function! LineNumberToggle()
  set nonumber norelativenumber!
endfunc

imap kj <Esc>
"nnoremap <Leader>l :!lazygit<CR>
nnoremap <silent> <leader>l :LazyGit<CR>
nnoremap <C-l> :call LineNumberToggle()<CR>
nnoremap <leader>n <cmd>CHADopen<cr>

" FZF Config
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=default', '--info=inline']}, <bang>0)
let g:fzf_layout = { 'down': '~20%' }

nnoremap <C-x> :Files<cr>
nnoremap <Space> :Buffers<cr>
nnoremap <C-f> :Rg<cr>

nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>

nnoremap gp :silent %!prettier --stdin-filepath %<CR>

nnoremap <C-k> :m-2<CR>
nnoremap <C-j> :m+<CR>
inoremap <C-k> <Esc>:m-2<CR>
inoremap <C-j> <Esc>:m+<CR>

" Move .viminfo file to ~/.vim/cache/.viminfo
if &compatible | set nocompatible | endif
set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/cache/.viminfo

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" disable auto comment on next line
autocmd FileType * set formatoptions-=cro

" AUTO CREATE DIRECTORY IF DOES NOT EXIST
augroup vimrc-auto-mkdir
 autocmd!
 autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
 function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
 endfunction
augroup END

" auto reload dwmblocks on change config.h
"autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
