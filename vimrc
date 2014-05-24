
" enable pathtogen plugin
" http://www.vim.org/scripts/script.php?script_id=2332
" Manage your vim 'runtimepath' with ease.  In practical terms, pathogen.vim makes
" it super easy to install plugins and runtime files in their own private
" directories. Just copy plugins to ~/.vim/bundle
call pathogen#infect() 

" use visual bell instead of beeping
set vb

" ctrl+t open new tab
map <C-t> <ESC>:tabnew<CR>
" ctrl+cursors navigate tabs
map <C-Right> <ESC>:tabnext<CR>
map <C-Left> <ESC>:tabprev<CR>

"required to detect filetypes (ftplugin) and indent
filetype plugin indent on

"autocompletion
set omnifunc=syntaxcomplete#Complete

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Do smart autoindenting when starting a new line
set smartindent

" for python and perl files <tab> = 4 spaces
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType perl set tabstop=4|set shiftwidth=4|set expandtab

"higlight code
syntax on

" better code highlight with dark background
set background=dark

"show the line numbers
"set number

" keep 50 lines of command line history
set history=50

" show the cursor position (line/column) all the time in the lower right corner
set ruler

" Suffixes that get lower priority when doing tab completion for filenames.
" " These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" F5 switch to paste mode if you are in insert mode
set pastetoggle=<F5>

" always in paste mode
"set paste

"show the `best match so far' as search strings are typed:
set incsearch
set hlsearch
" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

"Start in the last position when opening a file
if has("autocmd")
   augroup LastPos
   au!
   autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |  exe "normal g`\"" | endif
   augroup END
endif

" Execute file being edited in ipython with <Shift> + e:
"map <buffer> <S-e> :w<CR>:!ipython --no-confirm-exit % <CR>
map <buffer> <S-e> :w<CR>:!ipython --no-confirm-exit -i % <CR>
"map <buffer> <S-e> :w<CR>:!ipython --no-confirm-exit --InteractiveShellApp.hide_initial_ns=False -i % <CR>

" use space key to fold/unfold
nnoremap <space> za
vnoremap <space> zf
