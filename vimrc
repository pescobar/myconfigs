" enable pathtogen plugin
" http://www.vim.org/scripts/script.php?script_id=2332
" Manage your vim 'runtimepath' with ease.  In practical terms, pathogen.vim makes
" it super easy to install plugins and runtime files in their own private
" directories. Just copy plugins to ~/.vim/bundle
call pathogen#infect()

set background=dark

"higlight code
syntax on

" enable Omni-Completion (autocompletion)
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" for yaml files (ansible playbooks) <tab> = 2 spaces
autocmd FileType yaml set tabstop=2|set shiftwidth=2

" for python and perl files <tab> = 4 spaces
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType perl set tabstop=4|set shiftwidth=4|set expandtab

" use visual bell instead of beeping
"set vb

" ctrl+t open new tab
map <C-t> <ESC>:tabnew<CR>
" ctrl+cursors navigate tabs
map <C-Right> <ESC>:tabnext<CR>
map <C-Left> <ESC>:tabprev<CR>

" Do smart autoindenting when starting a new line
"set smartindent

" F5 switch to paste mode if you are in insert mode
set pastetoggle=<F5>

"show the `best match so far' as search strings are typed:
set incsearch
set hlsearch
"" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

"Start in the last position when opening a file
if has("autocmd")
   augroup LastPos
   au!
   autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |  exe "normal g`\"" | endif
   augroup END
endif

" copy/paste up to 1000 lines
set viminfo='50,<1000,s100,h

" enable modeline
set modeline
set modelines=5

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set laststatus=2

"to show top bar with buffers (vim-airline)
"let g:airline#extensions#tabline#enabled = 1

" to disable trailing white spaces detector (vim airline)
let g:airline#extensions#whitespace#enabled = 0

