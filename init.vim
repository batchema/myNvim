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

"Intellisense and Syntax Highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Typescript Support
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

call plug#end()

"*************** General ******************"
"Map jj and kk to <Esc> in Insert Mode
inoremap jj <Esc>
inoremap kk <Esc>

"show line number
set number

"autosave
autocmd TextChanged,TextChangedI <buffer> silent write

""""""" general formatting per file type
""C, javascript, python tab size
"(active config)
set expandtab
set shiftwidth=2
set softtabstop=2
filetype plugin indent on

"consider .ejs as html
autocmd BufWritePre *.ejs :setfiletype html
"autocmd BufWritePost *.ejs :setfiletype jst
au BufNewFile,BufRead *.ejs set filetype=html
"autocmd Filetype c setlocal tabstop=2
"autocmd Filetype c setlocal shiftwidth=2
"autocmd Filetype c setlocal expandtab
"
"autocmd Filetype js setlocal tabstop=2
"autocmd Filetype js setlocal shiftwidth=2
"autocmd Filetype js setlocal expandtab

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

" requires silversearcher-ag (sudo apt-get|brew install silversearch-ag)
" used to ignore gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"*************** Intellisense and Syntax Highlighting ******************"
let g:coc_global_extensions = [
      \'coc-emmet', 
      \'coc-pairs',
      \'coc-css', 
      \'coc-html', 
      \'coc-json', 
      \'coc-prettier', 
      \'coc-tsserver', 
      \'coc-java',
      \'coc-eslint',
      \'coc-snippets'
      \]

"Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

"*************** Tab Navigation ******************"
"gt   	go to next tab
"gT  	go to previous tab
"{i}gt  go to tab in position i
