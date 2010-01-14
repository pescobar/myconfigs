" vim config customized to fit my needs
" nice to work with bash and python files 
" also able to comment many different filetypes (NERD_commenter plugin)
" pescobar@cipf.es

" GLOBAL VIM SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf8

"required to detect filetypes (ftplugin) and indent
filetype plugin indent on

"higlight code
syntax on

"set status line at the second last line
set laststatus=2

"mark the line you're in
"set cursorline
"
"show the line numbers
set number

"color the line number in a different color
highlight LineNr guibg=lightblue ctermbg=lightgray

" keep 50 lines of command line history
set history=50

" show the cursor position all the time
set ruler

" Suffixes that get lower priority when doing tab completion for filenames.
" " These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

"open the referenced file in a new buffer
"map gf :edit <cfile><CR>

"show the `best match so far' as search strings are typed:
set incsearch
set hlsearch
" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" better code highlight with dark background
set background=dark

" F5 switch to paste mode
set pastetoggle=<F5>

"useful to paste (no autoindex)
set noai


" hide .pyc and hidden files
let g:explHideFiles='^\.,.*\.pyc$'
let g:netrw_list_hide='^\.,.*\.pyc$'
" f8 to browse hard disk
nnoremap <silent> <F8> :Explore<CR>

" {{{ Start in the last position "
"-----------------------------------"
if has("autocmd")
   augroup LastPos
   au!
   autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |  exe "normal g`\"" | endif
   augroup END
endif
"}}}

"autocompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

" Execute file being edited in ipython with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/ipython % <CR>

"changes the buffer in the current window to the next or the previous one
"map <C-right> <ESC>:bn<CR>
"map <C-left> <ESC>:bp<CR>
""Moves to the up or down window
"map <c-down> <ESC><C-W>j<CR>
"map <c-up> <ESC><C-W>k<CR>

" browse tabs
" new tab
"map <C-left><t> :tabnew<cr>
""previous tab
"map <C-left><left> :tabp<cr>
"" next tab
"map <C-left><right> :tabn<cr>

" use vim tabs with same keymaps than firefox
"set showtabline=2               " File tabs allways visible
":nmap <C-S-tab> :tabprevious<cr>
":nmap <C-tab> :tabnext<cr>
":nmap <C-t> :tabnew<cr>
":map <C-t> :tabnew<cr>
":map <C-S-tab> :tabprevious<cr>
":map <C-tab> :tabnext<cr>
":map <C-w> :tabclose<cr>
":imap <C-S-tab> <ESC>:tabprevious<cr>i
":imap <C-tab> <ESC>:tabnext<cr>i
":imap <C-t> <ESC>:tabnew<cr>

"folding without a plugin
"set foldmethod=indent
"an alternative way for python folding
"http://www.vim.org/scripts/script.php?script_id=2002


""""""""""""""""""""""""""""""""""""""""
" PLUGINS 
""""""""""""""""""""""""""""""""""""""""

" taglist plugin
"""""""""""""""""""""""""""""""""""""
" http://vim-taglist.sourceforge.net/
" F7 shows left window to browse classes
" you need Exuberant ctags to use this plugin
" if ctags is not availabe uncomment this to Skip loading the plugin
" let loaded_taglist = 'no'
nnoremap <silent> <F7> :TlistToggle<CR>
let Tlist_WinWidth = 40
let Tlist_Show_One_File = 1
""""""""""""""""""""""""""""""""""""""""


"Buffexplorer  NOT INSTALLED
"""""""""""""""""""""""""""""""""""""""
"http://vim.sourceforge.net/scripts/script.php?script_id=159
"BuffExplorer opens even with one
"let g:miniBufExplorerMoreThanOne=1
""""""""""""""""""""""""""""""""""""""""

"pylint
""""""""""""""""""""""""""""""""""""""""""
"http://www.vim.org/scripts/script.php?script_id=891
"assing pylint as compiler to the python files
autocmd FileType python compiler pylint
"To disable calling Pylint every time a buffer is saved put into .vimrc file
"let g:pylint_onwrite = 0
"Displaying code rate calculated by Pylint can be avoided by setting
"let g:pylint_show_rate = 0
"Openning of QuickFix window can be disabled with
"let g:pylint_cwindow = 0
"Of course, standard :make command can be used as in case

"if quickfix is the lastwindow I want it closed
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

" toggles the quickfix window.
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    execute "copen "
  endif
endfunction
" used to track the quickfix window
augroup QFixToggle
 autocmd!
 autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
 autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END
nmap <silent> <F6> :QFix<CR>

"the quickfix windown is not always 10 lines height
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" folding
"""""""""""""""""""""""""""""""""""""""""""
"uses space to toggle folding
nnoremap <space> za
vnoremap <space> zf

"plugin buftabs
"http://www.vim.org/scripts/script.php?script_id=1664
"""""""""""""""""""""""""""""""""""""""""""
set hidden
set laststatus=2
let g:buftabs_in_statusline=1
" default keymap is ctrl-left ctrl-right
map <C-o> :bprev!<CR>
map <C-p> :bnext!<CR>
" default keymap is ctrl-left ctrl-right
"map <C-Tab> :bprev!<CR>
"map <C-S-Tab> :bnext!<CR>

" bash support plugin
" http://www.vim.org/scripts/script.php?script_id=365
" http://informatica.escuelaedib.com/index.php?option=com_myblog&show=Personaliza-Vim-para-editar-bash-scripts.html&Itemid=59
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" header info for bash-support
let g:BASH_AuthorName   = 'Pablo Escobar'
let g:BASH_Email        = 'pescobar@cipf.es'
let g:BASH_Company      = 'bioinfo at CIPF'

"an interesting vim debugger
"http://vim.sourceforge.net/scripts/script.php?script_id=663

"a more interesting python debugger
"http://code.google.com/p/vimpdb/

"an interesting directory explorer
"http://vim.sourceforge.net/scripts/script.php?script_id=184

"more python goodies
"http://vim.wikia.com/wiki/Category:Python



"
"
"

