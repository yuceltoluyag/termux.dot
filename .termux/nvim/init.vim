"
"          ███████████████████████████
"          ███████▀▀▀░░░░░░░░▀▀▀███████
"          ████▀░░░░░░░░░░░░░░░░░▀████
"          ███│░░░░░░░░░░░░░░░░░░░│███
"          ██▌│░░░░░░░░░░░░░░░░░░░│▐██
"          ██░└┐░░░░░░░░░░░░░░░░░┌┘░██
"          ██░░└┐░░░░░░░░░░░░░░░┌┘░░██
"          ██░░┌┘▄▄▄▄▄░░░░░▄▄▄▄▄└┐░░██
"          ██▌░│██████▌░░░▐██████│░▐██
"          ███░│▐███▀▀░░▄░░▀▀███▌│░███
"          ██▀─┘░░░░░░░▐█▌░░░░░░░└─▀██
"          ██▄░░░▄▄▄▓░░▀█▀░░▓▄▄▄░░░▄██
"          ████▄─┘██▌░░░░░░░▐██└─▄████
"          █████░░▐█─┬┬┬┬┬┬┬─█▌░░█████
"          ████▌░░░▀┬┼┼┼┼┼┼┼┬▀░░░▐████
"          █████▄░░░└┴┴┴┴┴┴┴┘░░░▄█████
"          ███████▄░░░░░░░░░░░▄███████
"          ██████████▄▄▄▄▄▄▄██████████
"          ███████████████████████████
"
"      You are about to experience a potent
"        dosage of Vim. Watch your steps.
"
"  ╔══════════════════════════════════════════╗
"  ║             HERE BE VIMPIRES             ║
"  ╚══════════════════════════════════════════╝


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
call plug#begin('~/.vim/plugged')

" Otomatik tamamlama
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

if executable('python3')
  Plug 'zchee/deoplete-jedi'
endif

" Kod parçacıkları (Snippets)
Plug 'Shougo/neosnippet.vim' 
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" Kod yorumlama
Plug 'scrooloose/nerdcommenter'

" Dosya formatı uyumu
Plug 'editorconfig/editorconfig-vim'

" Gereksiz boşlukları yönetme
Plug 'ntpeters/vim-better-whitespace'

" Dikkat dağıtıcı unsurları azaltma (Distraction-free mode)
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

" Gelişmiş sözdizimi vurgulama
Plug 'sheerun/vim-polyglot'

" Vimwiki eklentisi
Plug 'vimwiki/vimwiki'

if executable('node')
  Plug 'suan/vim-instant-markdown', {'do': 'npm -g install instant-markdown-d' }
endif

call plug#end()

" Eklentiler yüklü değilse otomatik olarak yükle
autocmd VimEnter * if empty(glob('~/.vim/plugged/*')) | PlugInstall | endif

" Neosnippet ayarları
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'

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
