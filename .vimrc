set directory^=$HOME/.vim/tmp/


call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
call plug#end()


set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'

set laststatus=2
set autoread
set autoindent
set nowrap 
set mouse=a 
 
set cursorcolumn 
set cursorline 
"set ignorecase
set smartcase

" remap
nnoremap , `
imap kj <Esc>
inoremap <Esc> <Esc>`^
" remap for scripts
inoremap { {}<Esc>i<CR><Esc>%<S-a><CR><tab>
inoremap [ []<Esc>i
inoremap ( ()<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap ` ``<Esc>i
imap if<tab> if(<Esc><S-a>{<Esc>mij%hi
imap for<tab> for(<Esc><S-a>{<Esc>mij%hi
xnoremap ch c<!----><Esc>hhhp
xnoremap cj c/**/<Esc>hhp
xnoremap chh :s/^<!--//g\|'<,'>s/-->$//g
xnoremap cjj :s/^\/\*//g\|'<,'>s/\*\/$//g


let @t .= 'tabe | find '


"set termguicolors 
 
" for dark version 
"colors meh
set t_Co=256 
"set background=dark 
"colorscheme meh
set hlsearch 


if has('termguicolors')
 set termguicolors
endif
"let g:sonokai_style = 'atlantis'
"let g:sonokai_enable_italic = 1
"let g:sonokai_disable_italic_comment = 1
"colors sonokai
"colorscheme sonokai

" enter the current millenium 
set nocompatible 
 
" enable syntax and plugins (for netrw) 
syntax enable 
filetype plugin on 
set number relativenumber 

 
" FINDING FILES: 
 
" Search down into subfolders 
" Provides tab-completion for all file-related tasks 
set path+=** 
 
" Display all matching files when we tab complete 
set wildmenu 
 
let g:netrw_liststyle=3 
 
" use spaces for tabs 
set tabstop=2
set shiftwidth=2
set expandtab
" 
" " display indentation guides 
set list listchars=tab:❘\ ,trail:·,extends:»,precedes:«,nbsp:×
" 
" " convert spaces to tabs when reading file 
autocmd! bufreadpost * set noexpandtab | retab! 2 
" 
" " convert tabs to spaces before writing file 
autocmd! bufwritepre * set expandtab | retab! 2 

" " convert spaces to tabs after writing file (to show guides again) 
autocmd! bufwritepost * set noexpandtab | retab! 2

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
