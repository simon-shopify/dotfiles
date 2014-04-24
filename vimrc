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

set listchars=tab:→\ ,trail:×
set list

syntax on
colorscheme monokai

nnoremap <leader><space> :noh<cr>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'

let g:airline_powerline_fonts = 1

autocmd BufWritePre * :%s/\s\+$//e

" Go
autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

