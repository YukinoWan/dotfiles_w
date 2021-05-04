"vundle setting
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
filetype plugin indent on
let g:rainbow_active = 1
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"system
set fenc=utf-8
set shortmess+=I
set number
set relativenumber
set backspace=indent,eol,start
set mouse+=a
set encoding=utf-8
set shellslash
set hidden
set wildmenu
set lazyredraw
set confirm
set notimeout ttimeout ttimeoutlen=200
set magic
"set clipboard=unnamed
" utitity
set ignorecase
set smartcase
set nostartofline
set hlsearch
set incsearch
" input
set expandtab
set smarttab
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set autoindent
" display
set showcmd
set cmdheight=2
set number
set ruler
set rulerformat=%l,%v
set cursorline
set laststatus=2
set statusline+=%l,%v
set showmatch
set noerrorbells visualbell t_vb=
set scrolloff=999
set foldenable
set foldlevelstart=10
"mapping
let mapleader = ','
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
nnoremap <leader>nh :nohl<CR>
nnoremap <leader>nn :set nonumber<CR>
nnoremap <leader>an :set number<CR>
nnoremap <leader>t ggVG"+y

" plugins
syntax on
let g:tex_flavor='latex'
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SpecialKey ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
