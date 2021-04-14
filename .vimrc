call plug#begin('~/.vim/plugged')
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug '~/my-prototype-plugin'

Plug 'https://github.com/dylanaraps/wal.vim'
Plug 'tomasr/molokai'
Plug 'tomasiser/vim-code-dark'
Plug 'frazrepo/vim-rainbow'
Plug 'ervandew/supertab'
Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'
Plug 'ciaranm/inkpot'
Plug 'christoomey/vim-system-copy'
Plug 'djoshea/vim-autoread'
Plug 'vim-utils/vim-man'
call plug#end()

set relativenumber
set scrolloff=9
set number
set hidden
set incsearch
set noswapfile

colorscheme gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE
exec "hi Normal guibg=NONE ctermbg=NONE"
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
let g:SuperTabDefaultCompletionType = ""

