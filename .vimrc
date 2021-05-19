set nocompatible
filetype off
call plug#begin('~/.vim/plugged')
Plug '~/my-prototype-plugin'

Plug 'junegunn/vim-emoji'
Plug 'christoomey/vim-system-copy'
Plug 'djoshea/vim-autoread'
Plug 'vim-utils/vim-man'
Plug 'reconquest/vim-autosurround'
Plug 'alvan/vim-closetag'
Plug 'farmergreg/vim-lastplace'
Plug 'jiangmiao/auto-pairs'
Plug 'voldikss/vim-floaterm'
Plug 'ptzz/lf.vim'
Plug 'preservim/nerdtree'
Plug 'voldikss/vim-floaterm'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'yuezk/vim-js'
Plug 'turbio/bracey.vim'
" Beauty 
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-syntastic/syntastic'
Plug 'arzg/vim-colors-xcode'
Plug 'https://github.com/dylanaraps/wal.vim'
Plug 'tomasr/molokai'
Plug 'tomasiser/vim-code-dark'
Plug 'frazrepo/vim-rainbow'
Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'
Plug 'ciaranm/inkpot'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'python', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'ap/vim-css-color'

call plug#end()

set relativenumber
set scrolloff=9
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set number
set hidden
set incsearch
set noswapfile
set completefunc=emoji#complete


"autocmd VimEnter *
"    \ NERDTree |
"    \ vertical resize 20 |
"    \ execute "wincmd l" 
    
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost ~/.config/vim/vimrc source %
colorscheme deus
set background=dark
hi Normal guibg=NONE ctermbg=NONE
exec "hi Normal guibg=NONE ctermbg=NONE"
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
let g:SuperTabDefaultCompletionType = ""
let g:AutoPairsMapCh = '<C-h>'
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"



map <C-N> :NERDTree<CR>
nnoremap <C-X> :xa<CR>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
let g:user_emmet_leader_key=','


"coc.nvim
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
 set signcolumn=number
else
  set signcolumn=yes
endif
"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
"select first option and, enter will apply it
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd CursorHold * silent call CocActionAsync('highlight')



" fix cursor display in cygwin
if has("win32unix")
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endif

set mouse=a
