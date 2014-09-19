set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible.git'
Plugin 'tpope/vim-commentary'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline.git'
Plugin 'scrooloose/syntastic'
Plugin 'fatih/vim-go'
Plugin 'wting/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'kchmck/vim-coffee-script'

call vundle#end()
filetype plugin indent on

let mapleader=","
noremap \ ,

set number
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set hlsearch
set noswapfile

set listchars=tab:→\ ,trail:×
set list

syntax on
colorscheme monokai
hi SpecialKey ctermfg=59 ctermbg=235 cterm=bold

nnoremap <leader><space> :noh<cr>

"CtrlP stuff
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
let g:path_to_matcher = "matcher"
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_match_func = { 'match': 'GoodMatch' }

function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str

  return split(system(cmd), "\n")
endfunction

let g:airline_powerline_fonts = 1

autocmd BufWritePre * :%s/\s\+$//e

" Go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2

autocmd FileType go nmap <Leader>s <Plug>(go-implements)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)

autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)

autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)

" JS
let g:syntastic_jslint_checkers=['jslint']

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
