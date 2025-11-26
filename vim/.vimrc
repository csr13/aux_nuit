" ~/.vimrc — Modern, clean, working in 2025
" Works on Vim 8.2+, Neovim, and gvim

set nocompatible                  " Be iMproved, required for vim-plug
filetype off                      " Required for vim-plug init

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }     " Only load for Clojure
Plug 'vim-airline/vim-airline'                       " Keep only ONE statusline
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
" Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

" Auto-install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" === General settings ============================================
syntax enable                     " Enable syntax highlighting
set background=dark               " Better contrast for most colorschemes
colorscheme elflord               " Or try: gruvbox, desert, ron

set mouse=a                       " Enable mouse in all modes
set splitright                    " New vsplit goes right
set splitbelow                    " New split goes below
set backspace=indent,eol,start    " Make backspace work normally
set hidden                        " Allow hidden buffers
set number                        " Show line numbers
set cursorline                    " Highlight current line
set showcmd                       " Show partial commands
set wildmenu                      " Better command-line completion
set lazyredraw                    " Faster macros
set updatetime=300                " Faster CursorHold events

" === Indentation =================================================
set autoindent
set smartindent
set expandtab                     " Tabs → spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround                    " >> and << snap to shiftwidth

" === Search ======================================================
set ignorecase
set smartcase
set incsearch
set hlsearch                      " Highlight all matches

" Clear search highlight with <Esc>
nnoremap <silent> <Esc> :nohlsearch<CR>

" === Statusline (vim-airline) ====================================

set laststatus=2                  " Always show statusline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'      " or 'bubblegum', 'luna', etc.
let g:airline_section_b = '💀😈csr13 😈💀'

" === Key mappings ================================================
" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" NERDTree toggle
nnoremap <C-n> :NERDTreeToggle<CR>

" EasyAlign shortcut
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" === Filetype-specific ===========================================
filetype plugin indent on         " Enable after plugins

autocmd FileType html,xml setlocal textwidth=0    " Don't hard-wrap HTML
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript,typescript,json setlocal ts=2 sts=2 sw=2

