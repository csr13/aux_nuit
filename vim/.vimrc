

if &t_Co > 1
    syntax enable
endif

if has('mouse')
    set mouse=a
endif 

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

set nocompatible    " Set compatibility to Vim only
set textwidth=85    " lines longer than 79 columns will be broken
set shiftwidth=4    " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4       " a hard TAB displays as 4 columns
set expandtab       " insert spaces when hitting TABs
set softtabstop=4   " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround      " round indent to multiple of 'shiftwidth'
set autoindent      " align the new line indent with the previous line
set splitright      " split sp: to the right
set backspace=indent,eol,start
set completeopt-=preview

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html set textwidth=256

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif

filetype plugin indent on " required

set laststatus=2    " required
