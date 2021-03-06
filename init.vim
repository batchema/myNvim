"*************** Plugins ******************"
call plug#begin("~/.vim/plugged")
"Theming
  Plug 'dracula/vim'
  Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'jacoborus/tender.vim'
  Plug 'sainnhe/sonokai'
  
  "File Explorer10
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  
  "Comments
  Plug 'preservim/nerdcommenter'
  
  "File Search
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  
  "Intellisense and Syntax Highlighting
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "JSX 
  "Plug 'maxmellon/vim-jsx-pretty'
  "Typescript 
  "Plug 'leafgarland/typescript-vim'
  "Plug 'peitalin/vim-jsx-typescript'
  
  "One Plugin to replace them all
  Plug 'sheerun/vim-polyglot'
  "Added as ejs highlighting dependency
  Plug 'pangloss/vim-javascript'
  
  "C and C++ syntax highlighting
  Plug 'bfrg/vim-cpp-modern'
call plug#end()
"*************** General ******************"
"Map jj and kk to <Esc> in Insert Mode
inoremap jj <Esc>
inoremap kk <Esc>

"show line number
set number

"leader key
"nnoremap <SPACE> <Nop>
"map <Space> <Leader>
let mapleader = " "

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
autocmd BufWritePost *.ejs :setfiletype jst
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
set background=dark

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
  resize 15
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
" use <leader>+hjkl to move between split/vsplit panels
tnoremap <leader>h <C-\><C-n><C-w>h
tnoremap <leader>j <C-\><C-n><C-w>j
tnoremap <leader>k <C-\><C-n><C-w>k
tnoremap <leader>l <C-\><C-n><C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

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

"*************** Intellisense and Syntax Highlighting (COC configs)******************"
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

"*** From ianding.io *****"
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Tab completion
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"********************"

"let g:coc_disable_startup_warning = 1 
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

"****** C and C++ Syntax highlighting **********""

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

"*************** Tab Navigation ******************"
"gt   	go to next tab
"gT  	go to previous tab
"{i}gt  go to tab in position i
