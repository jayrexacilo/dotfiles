let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'jreybert/vimagit'
Plug 'lukesmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'cormacrelf/vim-colors-github'
Plug 'tpope/vim-fugitive'
Plug 'zivyangll/git-blame.vim'
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
Plug 'mcchrish/nnn.vim'
call plug#end()

set title
set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set noshowmode
set noruler
set laststatus=0
set noshowcmd

" Some basics:
  nnoremap c "_c
  set nocompatible
  filetype plugin on
  syntax on
  set encoding=utf-8
  set number relativenumber
" Enable autocompletion:
  set wildmode=longest,list,full
" Disables automatic commenting on newline:
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
  vnoremap . :normal .<CR>
" Goyo plugin makes text more readable when writing prose:
  map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
  map <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
  set splitbelow splitright

" Nerd tree
  map <leader>n :NERDTreeToggle<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	if has('nvim')
		let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
	else
		let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
	endif

" vimling:
  nm <leader><leader>d :call ToggleDeadKeys()<CR>
  imap <leader><leader>d <esc>:call ToggleDeadKeys()<CR>a
  nm <leader><leader>i :call ToggleIPA()<CR>
  imap <leader><leader>i <esc>:call ToggleIPA()<CR>a
  nm <leader><leader>q :call ToggleProse()<CR>

" Shortcutting split navigation, saving a keypress:
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

" Replace ex mode with gq
  map Q gq

" Check file in shellcheck:
  map <leader>s :!clear && shellcheck -x %<CR>

" Open my bibliography file in split
  map <leader>b :vsp<space>$BIB<CR>
  map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
  nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
  map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
  map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
  autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
  let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
  map <leader>v :VimwikiIndex
  let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
  autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
  autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
  autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
  cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
  autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
  autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
  autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
  autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

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

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
	if s:hidden_all  == 0
		let s:hidden_all = 1
		set noshowmode
		set noruler
		set laststatus=0
		set noshowcmd
	else
		let s:hidden_all = 0
		set showmode
		set ruler
		set laststatus=2
		set showcmd
	endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

try
	nmap <silent> [c :call CocAction('diagnosticNext')<cr>
	nmap <silent> ]c :call CocAction('diagnosticPrevious')<cr>
endtry

"function! ShowDocIfNoDiagnostic(timer_id)
" if (coc#util#has_float() == 0)
"	silent call CocActionAsync('doHover')
" endif
"endfunction
"
"function! s:show_hover_doc()
" call timer_start(500, 'ShowDocIfNoDiagnostic')
"endfunction
"
"autocmd CursorHoldI * :call <SID>show_hover_doc()
"autocmd CursorHold * :call <SID>show_hover_doc()

nnoremap <silent> K :call CocAction('doHover')<CR>

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

filetype plugin indent on
set smartindent
autocmd BufRead,BufWritePre *.sh normal gg=G

set cursorcolumn
set cursorline
"set ignorecase
set smartcase

" remap
"nnoremap , `
let mapleader = ","

"nnn.vim configs
" Disable default mappings
let g:nnn#set_default_mappings = 0

" Then set your own
nnoremap <silent> <leader>nn :NnnPicker<CR>
" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
let g:nnn#action = {
	  \ '<c-t>': 'tab split',
	  \ '<c-x>': 'split',
	  \ '<c-v>': 'vsplit' }

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

"nmap <silent> <leader>n :ALENext<cr>
"nmap <silent> <leader>p :ALEPrevious<cr>
nnoremap <Leader>bb :<C-u>call gitblame#echo()<CR>

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
set tabstop=4
set shiftwidth=4
set expandtab
"
" " display indentation guides
set list listchars=tab:❘\ ,trail:·,extends:»,precedes:«,nbsp:×
"
" " convert spaces to tabs when reading file
autocmd! bufreadpost * set noexpandtab | retab! 4
"
" " convert tabs to spaces before writing file
autocmd! bufwritepre * set expandtab | retab! 4

" " convert spaces to tabs after writing file (to show guides again)
autocmd! bufwritepost * set noexpandtab | retab! 4

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
