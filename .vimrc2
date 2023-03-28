syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set number relativenumber
set hlsearch
set ruler
set background=dark
set t_Co=256

highlight LineNr ctermfg=grey cterm=bold
autocmd BufNewFile,BufRead * setlocal formatoptions-=ro

let g:netrw_liststyle=3

set list listchars=tab:❘\ ,trail:·,extends:»,precedes:«,nbsp:× "display indentation guides
autocmd! bufreadpost * set noexpandtab | retab! 2 "convert spaces to tabs when reading file
autocmd! bufwritepre * set expandtab | retab! 2 "convert tabs to spaces before writing file
autocmd! bufwritepost * set noexpandtab | retab! 2 "convert spaces to tabs after writing file (to show guides again)

imap kj <Esc>
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

" FINDING FILES:
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
set wildignore+=**/bower_components/**,**/node_modules/**,**vendor/bundle**,.git,.git/**
set wildmenu " Display all matching files when we tab complete

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat+=%f:%l:%c:%m
nnoremap <Leader>g :silent lgrep<Space>
nnoremap <silent> [f :lprevious<CR>
nnoremap <silent> ]f :lnext<CR>
