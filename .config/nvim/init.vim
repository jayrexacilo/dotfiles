if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
"Plug 'pbrisbin/vim-colors-off'
Plug 'sheerun/vim-polyglot'
"Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'nanotech/jellybeans.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'chriskempson/base16-vim'
Plug 'zivyangll/git-blame.vim'
"Plug 'dense-analysis/ale'
"Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

autocmd ColorScheme * highlight CursorLineNr guifg=yellow
autocmd ColorScheme * highlight LineNr guifg=white
autocmd ColorScheme * highlight TabLineSel guifg=yellow
autocmd ColorScheme * highlight TabLine guifg=white guibg=black
autocmd ColorScheme * highlight Comment guifg=#35A99E guibg=black

" fzf mappings
nnoremap <expr> <C-x> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
let g:rg_command = 'rg --vimgrep -S'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'


set clipboard+=unnamedplus

" Shortcutting split navigation, saving a keypress:
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

" Ensure files are read as what I want:
  let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
  map <leader>v :VimwikiIndex
  let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
  autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
  autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
  autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
  cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save.
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritePre * %s/\n\+\%$//e
  autocmd BufWritePre *.[ch] %s/\%$/\r/e

" When shortcut files are updated, renew bash and ranger configs with new material:
  autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
  autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
  autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
  autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
  highlight! link DiffText MatchParen
endif

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

try
  nmap <silent> [c :call CocAction('diagnosticNext')<cr>
  nmap <silent> ]c :call CocAction('diagnosticPrevious')<cr>
endtry

nnoremap <silent> K :call CocAction('doHover')<CR>

"Highlighting for large files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

set t_Co=256
set hlsearch

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" use the dark theme
set background=dark

" more blocky diff markers in signcolumn (e.g. GitGutter)
colorscheme base16-black-metal-mayhem

set laststatus=2
set autoread
set autoindent
set nowrap
set mouse=a

filetype plugin indent on
set smartindent
autocmd BufRead,BufWritePre *.sh normal gg=G

set cursorcolumn
set cursorline
"set ignorecase
set smartcase

" remap
"nnoremap , `
let mapleader =","

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

nnoremap <Leader>bb :<C-u>call gitblame#echo()<CR>
imap kj <Esc>

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
set wildignore+=**/bower_components/**,**/node_modules/**,**vendor/bundle**,.git,.git/**

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

"curl
command Exec set splitright | vnew | set filetype=sh | read !sh #
