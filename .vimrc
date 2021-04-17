" ____   ____.___   _____  _________  ________    _______  ___________
" \   \ /   /|   | /     \ \_   ___ \ \_____  \   \      \ \_   _____/
"  \   Y   / |   |/  \ /  \/    \  \/  /   |   \  /   |   \ |    __)  
"   \     /  |   /    Y    \     \____/    |    \/    |    \|     \   
"    \___/   |___\____|__  /\______  /\_______  /\____|__  /\___  /   
"                        \/        \/         \/         \/     \/    


if &t_Co > 1
    syntax enable
endif

if has('mouse')
    set mouse=a
endif 

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

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

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'gmarik/Vundle.vim'      " required by Vundle
Plugin 'Valloric/YouCompleteMe' " Auto Complete plugin for Python.
Plugin 'preservim/nerdtree'     " File browsing tree
Plugin 'itchyny/lightline.vim'  " statusline
Plugin 'prettier/vim-prettier'
Plugin 'jaredgorski/spacecamp'  " Colorscheme


call vundle#end()         " required

colorscheme spacecamp

let g:lightline = {
    \   'colorscheme': 'wombat',
    \   'active' : {
    \       'left' : [
    \           [ 'mode', 'paste' ],
    \           [ 'readonly', 'filename', 'modified', 'xxx' ]
    \       ]
    \   },
    \   'component' : {
    \       'xxx' : "How you doing sexy?!"
    \   },
    \}

filetype plugin indent on " required

set laststatus=2    " required
