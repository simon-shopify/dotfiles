let mapleader=","
noremap \ ,

execute pathogen#infect()

set number
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set hlsearch
set mouse=a

syntax on
colorscheme monokai

nnoremap <leader><space> :noh<cr>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'

autocmd BufWritePre * :%s/\s\+$//e

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

