if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif



call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'kdheepak/lazygit.nvim'
Plug 'bignimbus/pop-punk.vim'
Plug 'mattn/emmet-vim'
Plug 'zivyangll/git-blame.vim'
Plug 'tpope/vim-fugitive'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mkitt/tabline.vim'
Plug 'ap/vim-css-color'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdtree'
call plug#end()

autocmd! bufreadpost * set noexpandtab | retab! 2 "convert spaces to tabs when reading file
autocmd! bufwritepre * set expandtab | retab! 2 "convert tabs to spaces before writing file
autocmd! bufwritepost * set noexpandtab | retab! 2 "convert spaces to tabs after writing file (to show guides again)
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Enable autocompletion:
set wildmode=longest,list,full
" Save file as sudo on files that require root permission
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Ensure files are read as what I want:
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :VimwikiIndex<CR>
let g:vimwiki_list = [{'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

filetype plugin indent on
syntax on
colorscheme pop-punk

set t_Co=256
set cursorline
set cursorcolumn
set background=dark
set tabstop=2
set shiftwidth=2
set expandtab
set cindent
set ai
set number relativenumber
set hlsearch
set ruler
set mouse=n
set clipboard+=unnamedplus
set path+=**
set wildignore+=**/bower_components/**,**/node_modules/**,**vendor/bundle**,.git,.git/**
set wildmenu
set list listchars=tab:❘\ ,trail:·,extends:»,precedes:«,nbsp:× "display indentation guides

let mapleader =","
let g:netrw_liststyle=3


imap kj <Esc>
nnoremap <C-h> :vertical resize -10<CR>
nnoremap <C-l> :vertical resize +10<CR>
nnoremap <C-j> :horizontal resize +10<CR>
nnoremap <C-k> :horizontal resize -10<CR>

nnoremap <silent> <leader>l :LazyGit<CR>
nnoremap <Leader>bb :<C-u>call gitblame#echo()<CR>

" simple finding text in files
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat+=%f:%l:%c:%m
nnoremap <Leader>g :silent lgrep<Space>
nnoremap <Leader><S-p> :lprevious<CR>
nnoremap <Leader><S-n> :lnext<CR>

" Nerd tree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	if has('nvim')
			let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
	else
			let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
	endif

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

hi Normal guibg=NONE ctermbg=NONE
hi CursorLine guibg=#0D1016 ctermbg=NONE
hi CursorColumn guibg=#0D1016 ctermbg=NONE
hi normal guibg=000000


""""""""""""""""""""""""""" VIM SESSION START
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
""""""""""""""""""""""""""" VIM SESSION END





""""""""""""""""""""" FZF Start
" Get text in files with Rg
command! -bang -nargs=* Rg
	\ call fzf#vim#grep(
	\		'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
	\		fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
	let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
	let initial_command = printf(command_fmt, shellescape(a:query))
	let reload_command = printf(command_fmt, '{q}')
	let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

function RgFzF()
	command! -bang -nargs=* Rg
		\ call fzf#vim#grep(
		\		'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
		\		fzf#vim#with_preview(), <bang>0)
endfunction
autocmd UIEnter * :call RgFzF()

" fzf mappings
nnoremap <expr> <C-x> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
nnoremap <C-Space> :Rg<CR>
let g:rg_command = 'rg --vimgrep -S'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

""""""""""""""""""""" FZF END

augroup vimrc-auto-mkdir
	autocmd!
	autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
	function! s:auto_mkdir(dir, force)
		if !isdirectory(a:dir)
					\		&& (a:force
					\				|| input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
			call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
		endif
	endfunction
augroup END

" auto reload dwmblocks on change config.h
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
