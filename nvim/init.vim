set background=dark            "Dark colors for screen
set clipboard=unnamedplus      "Share nvim and system clipboard
set hidden 		               "hide unused buffers
set number                     "show line numbers
"set relativenumber             "line numbers relative to current line
set splitbelow splitright      "splits open below or to the right
set title 	                   "show file title

filetype plugin indent on      "indent on file type
filetype plugin on
syntax on                      "syntax highlighting

"tabs and spaces
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent

set t_Co=256                   "256 color terminal

"auto-install plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"plugins
call plug#begin()
    Plug 'preservim/nerdtree'
    "colorschemes
    Plug 'projekt0n/github-nvim-theme'
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'navarasu/onedark.nvim'
    Plug 'morhetz/gruvbox'
    Plug 'sainnhe/sonokai'
    Plug 'sainnhe/gruvbox-material'

    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jlanzarotta/bufexplorer'
    Plug 'preservim/nerdcommenter'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/nvim-treesitter-context'
call plug#end()

colorscheme gruvbox

"Toggle background dark and light - might be gruvbox specific
function ToggleBackgroundOfEditor()
    let &background = &background == "dark" ? "light" : "dark"
endfunction

nnoremap <silent> <LocalLeader>td :call ToggleBackgroundOfEditor()<CR>


"Key remapping stuff

"NERDTree
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>

" FZF
function! SmartFuzzy()
  let root = split(system('git rev-parse --show-toplevel'), '\n')
  if len(root) == 0 || v:shell_error
    Files
  else
    GFiles -co --exclude-standard -- . ':!:vendor/*'
  endif
endfunction

command! -nargs=* SmartFuzzy :call SmartFuzzy()
map <silent> <leader>ff :SmartFuzzy<CR>

"COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
