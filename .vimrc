call plug#begin('~/.vim/plugged')

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Plugins 
Plug 'https://github.com/dylanaraps/wal.vim'
Plug 'tomasr/molokai'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tomasiser/vim-code-dark'
Plug 'frazrepo/vim-rainbow'
Plug 'morhetz/gruvbox'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'

" Initialize plugin system
call plug#end()


"colorscheme codedark
"colorscheme gruvbox
colorscheme molokai
"colorscheme vim-monokai-tasty
"let g:airline_theme='monokai_tasty'

"let g:solarized_termcolors=256
"colorscheme solarized

" [Transparency with colorschemes]
hi Normal guibg=NONE ctermbg=NONE
"hi NonText ctermbg=NONE guibg=NONE
" cursor chanes depending on current mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" for vim rainbow 
let g:rainbow_active = 1

