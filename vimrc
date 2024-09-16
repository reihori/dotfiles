let mapleader = "\<space>"

let s:dotvimdir = $HOME .. '/.vim'
let s:jetpackfile = s:dotvimdir .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
if !filereadable(s:jetpackfile)
	if executable('curl')
		let s:cmd = printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl)
		echo '> ' .. s:cmd
		call system(s:cmd)
		echo 'Jetpack has been installed. Please restart vim and run :JetpackSync command.'
	else
		echo 'You need `curl` to install Jetpack.'
	endif
else
	packadd vim-jetpack
	call jetpack#begin()
	Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
	Jetpack 'tpope/vim-commentary'
	Jetpack 'easymotion/vim-easymotion'
	Jetpack 'jiangmiao/auto-pairs'
	Jetpack 'itchyny/lightline.vim'
	call jetpack#end()
	let g:EasyMotion_do_mapping = 0
	nnoremap <leader><leader> <Plug>(easymotion-s)
	let g:lightline = {
		\ 'colorscheme': 'wombat',
		\ }
endif

nnoremap <leader>w <cmd>update<cr>

set laststatus=2
set noswapfile
set relativenumber
set showcmd
set smartindent
set tabstop=4
set viminfo=
