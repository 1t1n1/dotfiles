set nocompatible

" Start of VimPlug
call plug#begin()

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'ycm-core/YouCompleteMe'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()
" End of VimPlug

colorscheme pablo

set number relativenumber
set tabstop=4
set shiftwidth=4

" Copy visually selected text to clipboard
vnoremap <C-c> "+y

" Paste from clipboard
nnoremap <C-v> "+p
inoremap <C-v> "+p

