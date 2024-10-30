syntax on
syntax enable
filetype plugin on
set scrolloff=20
set number relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set number
set hlsearch
set ruler
set background=dark
set ttimeout
set ttimeoutlen=100
set timeoutlen=200
set path+=**
set wildmenu

imap kj <Esc>

" FILE BROWSING:

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Set tab width to 4 for PHP files
autocmd FileType php setlocal tabstop=4 shiftwidth=4 expandtab
