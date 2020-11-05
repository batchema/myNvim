"*************** Plugins ******************"
call plug#begin("~/.vim/plugged")
"Theming
Plug 'dracula/vim'
"File Explorer
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
"File Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

"*************** General ******************"
"Map jj and kk to <Esc> in Insert Mode
inoremap jj <Esc>
inoremap kk <Esc>

"show line number
set number

"autosave
autocmd TextChanged,TextChangedI <buffer> silent write

"formatting per file type
autocmd Filetype c setlocal tabstop=2
autocmd Filetype c setlocal shiftwidth=2
autocmd Filetype c setlocal expandtab

"*************** Theming ******************"
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

"*************** File Explorer ******************"
" CTRL-B to open and close the side explorer
""" Configuration
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

"*************** Integrated Terminal ******************"
"Configuration
"CTRL-N to open
"ESC to Quit
"CTRL+ww to move between panels 
"or alt+hjkl (these can be finicky)

" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"*************** File Searching ******************"
" Configuration
" CTRL+P to search the file
" CTRL+T to open it in a new tab.
" CTRL+S to open below (split view).
" CTRL+V to open to the side (vertical split).<Paste>
 
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

"*************** Tab Navigation ******************"
"gt   	go to next tab
"gT  	go to previous tab
"{i}gt  go to tab in position i
