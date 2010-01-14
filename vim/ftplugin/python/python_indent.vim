"http://henry.precheur.org/2008/4/18/Indenting_Python_with_VIM.html
"http://py.vaults.ca/~x/python_and_vim.html
"how many spaces a single tab looks like
setlocal tabstop=4
"This allows you to use the < and > keys from VIM's visual (marking)
"mode to block indent/unindent regions
setlocal shiftwidth=4
"Use the 'shiftwidth' setting for inserting <TAB>s instead of the 'tabstop'
"setting, when at the beginning of a line. This may be redundant for most
"people, but some poeple like to keep their tabstop=8 for compatability
"when loading files, but setting shiftwidth=4 for nicer coding style.
setlocal smarttab
"Insert spaces instead of <TAB> character when the <TAB> key is pressed
setlocal expandtab
"how many spaces a single tab is
"makes VIM see multiple space characters as tabstops, and so <BS>
"does the right thing and will delete four spaces
setlocal softtabstop=4
"It means that when you press RETURN and a new line is created,
"the indent of the new line will match that of the previous line
"setlocal autoindent

setlocal smartindent

"It means that after typing lines which start with any of the keywords
"in the list (ie. def, class, if, etc) the next line will automatically
"indent itself to the next level of indentation
"setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"Many people like to remove any extra whitespace from the ends of lines.
"Here is one way to do it when saving your file.
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

setlocal textwidth=79
