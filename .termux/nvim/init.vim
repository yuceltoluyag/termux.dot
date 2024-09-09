" Genel ayarlar
syntax on
filetype plugin on
set expandtab
set shiftwidth=2
set tabstop=2
set hidden
set number
set laststatus=2 " Durum çubuğunu görünür yap
set shortmess+=afilmnrxoOtT
set listchars=eol:¬,tab:»\ ,trail:~,extends:»,precedes:«
set history=1000 " Komut geçmişi için daha fazla alan
set lazyredraw " Performansı artırmak için ekran güncellemelerini ertele
set updatetime=300 " Daha hızlı yanıt süresi için bekleme süresini azalt

" Tema ve renkler
colorscheme Tomorrow-Night-Eighties
hi Normal ctermbg=none

" Esc tuşu yerine 'jj' kullanımı
imap jj <Esc>

" Lider tuşu
let mapleader=','

" Eklenti yönetimi
call plug#begin('~/.local/share/nvim/plugged')  " Neovim için doğru dizin

" Eklentiler
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

if executable('python3')
  Plug 'zchee/deoplete-jedi'
endif

Plug 'Shougo/neosnippet.vim' 
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'sheerun/vim-polyglot'
Plug 'vimwiki/vimwiki'

if executable('node')
  Plug 'suan/vim-instant-markdown', {'do': 'npm -g install instant-markdown-d' }
endif

call plug#end()

" Eğer eklentiler yüklü değilse otomatik olarak yükle
autocmd VimEnter * if empty(glob('~/.local/share/nvim/plugged/*')) | PlugInstall | endif

" Neosnippet ayarları
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.local/share/nvim/plugged/vim-snippets/snippets'

" Deoplete ayarları
let g:deoplete#enable_at_startup = 1

" Python 2'yi devre dışı bırak
let g:loaded_python_provider = 1

" Vimwiki ayarları
let g:vimwiki_list=[{'path': '~/.wiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

if executable('node')
  let g:instant_markdown_slow = 1
  let g:instant_markdown_autostart = 0
  map <leader>md :InstantMarkdownPreview<CR>
endif
