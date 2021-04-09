"reference: https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim#highlighting-for-large-files
set directory^=$HOME/.vim/tmp/

call plug#begin('~/.vim/plugged')
Plug 'mattn/emmet-vim'
Plug 'cormacrelf/vim-colors-github'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'dense-analysis/ale'
"Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'mkitt/tabline.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#util#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" eslint config
"let g:ale_fixers = ['prettier', 'eslint']
"let g:ale_sign_error = '❌'
"let g:ale_sign_warning = '⚠️'
"let g:syntastic_javascript_eslint_exe = 'npm run eslint --'
"let g:ale_fix_on_save = 1
"let g:ale_completion_enabled = 1
"let g:ale_completion_autoimport = 1

"Highlighting for large files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_show_hidden = 1
set runtimepath^=~/.vim/plugged/ctrlp.vim

set t_Co=256 
set hlsearch 

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" use a slightly darker background, like GitHub inline code blocks
let g:github_colors_soft = 1

" use the dark theme
set background=dark

" more blocky diff markers in signcolumn (e.g. GitGutter)
let g:github_colors_block_diffmark = 0
colorscheme github

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
"nnoremap , `
let mapleader = ","

function GetSessionDir()
  let g:session_dir = '~/.vim-sessions'
  let g:proj_dir = split($PWD, '/')[-1]
  if empty(glob(expand('~/.vim-sessions')))
    exec 'silent !mkdir '.g:session_dir.' > /dev/null 2>&1'
  endif
  if empty(glob(expand('~/.vim-sessions/'.g:proj_dir)))
    exec 'silent !mkdir '.g:session_dir.'/'.g:proj_dir.'> /dev/null 2>&1'
  endif
  return g:session_dir.'/'.g:proj_dir
endfunction

exec 'nnoremap <leader>ss :mks! '. GetSessionDir() .'/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <leader>sr :so '. GetSessionDir() .'/*.vim<C-D><BS><BS><BS><BS><BS>'

nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>q :q<cr>
nnoremap <silent> <leader>aq :qal<cr>
imap kj <Esc>
inoremap <Esc> <Esc>`^
" remap for scripts
"inoremap { {}<Esc>i
"inoremap [ []<Esc>i
"inoremap ( ()<Esc>i
"inoremap " ""<Esc>i
"inoremap ' ''<Esc>i
"inoremap ` ``<Esc>i
"imap if<tab> if(<Esc><S-a>{<Esc>mij%hi
"imap for<tab> for(<Esc><S-a>{<Esc>mij%hi
xnoremap ch c<!----><Esc>hhhp
xnoremap cj c/**/<Esc>hhp
xnoremap chh :s/^<!--//g\|'<,'>s/-->$//g
xnoremap cjj :s/^\/\*//g\|'<,'>s/\*\/$//g

nmap <silent> <leader>n :ALENext<cr>
nmap <silent> <leader>p :ALEPrevious<cr>

let @t .= 'tabe | find '

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
set wildignore+=**/node_modules/**

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
