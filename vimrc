let mapleader = "\<space>"

let s:jetpackfile = expand('<sfile>:p:h') .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
if !filereadable(s:jetpackfile)
	call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif
packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'tpope/vim-commentary'
Jetpack 'easymotion/vim-easymotion'
Jetpack 'jiangmiao/auto-pairs'
call jetpack#end()
let g:EasyMotion_do_mapping = 0
nnoremap <leader><leader> <Plug>(easymotion-s)

nnoremap <leader>w <cmd>update<cr>

set laststatus=2
set noswapfile
set relativenumber
set viminfo=
