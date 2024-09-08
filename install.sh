#!/data/data/com.termux/files/usr/bin/bash

elixir=false
golang=false
python=false
nvimrc=false
nodejs=false
tmux=false
ruby=false
php=false
postgres=false
zsh=false

function show_usage() {
    echo -e "\\e[32mKullanım: install.sh [seçenekler]\\e[m"
    echo -e "Kullanabileceğiniz seçenekler:"
    echo -e "  -e, --elixir        Elixir'i kur"
    echo -e "  -g, --go, --golang  Go'yu kur"
    echo -e "  -p, --python        Python'ı kur"
    echo -e "  -n, --nvim, --neovim Neovim'i kur"
    echo -e "  -js, --nodejs       Node.js'i kur"
    echo -e "  -t, --tmux          Tmux'u kur"
    echo -e "  -r, --ruby          Ruby'yi kur"
    echo -e "  --php               PHP'yi kur"
    echo -e "  -pg, --postgres     PostgreSQL'i kur"
    echo -e "  -z, --zsh           Zsh'i kur"
    echo -e "  -a, --all           Tüm yazılımları kur"
    echo -e "\\e[31mÖrnek: ./install.sh --all\\e[m"
}

if [ $# -eq 0 ]; then
    show_usage
    exit 1
fi

# Root izni kontrolü
function check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "\\e[31m[ UYARI ]\\e[m Root izni bulunmuyor. Root izni olmadan bazı işlemler başarısız olabilir."
        read -p "Devam etmek istiyor musunuz? (E/h): " -n 1 -r
        echo    # Yeni satıra geç
        if [[ ! $REPLY =~ ^[Ee]$ ]]; then
            echo "Kurulum iptal edildi."
            exit 1
        fi
    else
        echo -e "\\e[32m[ Root ]\\e[m Root izni mevcut."
    fi
}

# termux-setup-storage izni kontrolü
function check_storage_permission() {
    if [ -d "$HOME/storage" ]; then
        echo -e "\\e[32m[ Depolama ]\\e[m ~/storage dizini zaten mevcut."
        read -p "Depolama yapısını yeniden oluşturmak istiyor musunuz? (Bu mevcut verileri değiştirebilir) (E/h): " -n 1 -r
        echo    # Yeni satıra geç
        if [[ $REPLY =~ ^[Ee]$ ]]; then
            termux-setup-storage
            echo -e "\\e[32m[ Depolama ]\\e[m Depolama yapısı yeniden oluşturuldu."
        else
            echo -e "\\e[33m[ UYARI ]\\e[m Depolama yapısı yeniden oluşturulmadı. Devam ediliyor..."
        fi
    else
        termux-setup-storage
        echo -e "\\e[32m[ Depolama ]\\e[m Depolama izni verilmiş."
    fi
}

function install_zsh() {
    if ! [ -x "$(command -v zsh)" ]; then
        echo -e "\\e[32m[ zsh ]\\e[m bulunamadı, yükleniyor"
        pkg install -y zsh >/dev/null 2>&1 && echo "Zsh başarıyla yüklendi" || echo "Zsh yükleme başarısız"
    fi
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "\\e[32m[ oh-my-zsh ]\\e[m deposu kopyalanıyor"
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" --depth 1 --quiet >/dev/null
    fi
    curl -fsLo "$HOME/.oh-my-zsh/themes/lambda-mod.zsh-theme" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/lambda-mod.zsh-theme
    curl -fsLo "$HOME/.zshrc" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/.zshrc
    curl -fsLo "$HOME/.profile" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/.profile
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
        echo -e "\\e[32m[ oh-my-zsh ]\\e[m sözdizimi vurgulama eklentisi indiriliyor"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" --quiet >/dev/null
    fi
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
        echo -e "\\e[32m[ oh-my-zsh ]\\e[m otomatik öneri eklentisi indiriliyor"
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" --quiet >/dev/null
    fi

    chsh -s zsh
}

function install_elixir() {
    # unzip kurulu değilse yükle
    if ! [ -x "$(command -v unzip)" ]; then
        echo -e "\\e[32m[ unzip ]\\e[m bulunamadı, yükleniyor"
        pkg install -y unzip >/dev/null 2>&1 && echo "Unzip başarıyla yüklendi" || echo "Unzip yükleme başarısız"
    fi

    mkdir -p "$HOME/.elixir" && cd "$HOME/.elixir" || exit

    echo -e "\\e[32m[ elixir ]\\e[m en güncel versiyonu indiriliyor"
    curl -L https://github.com/elixir-lang/elixir/releases/download/v1.17.2/elixir-otp-27.zip -o elixir-otp-27.zip
    unzip -qq elixir-otp-27.zip && rm elixir-otp-27.zip
    cd bin || exit
    echo -e "\\e[32m[ elixir ]\\e[m ikili dosyalar düzeltiliyor"
    termux-fix-shebang elixir elixirc iex mix
    echo 'export PATH="$PATH:$HOME/.elixir/bin"' >> "$HOME/.profile"
    cd "$HOME" || exit
}


function install_node() {
    if ! [ -x "$(command -v node)" ]; then
        echo -e "\\e[32m[ nodejs ]\\e[m bulunamadı, yükleniyor"
        pkg install -y nodejs >/dev/null 2>&1 && echo "Node.js başarıyla yüklendi" || echo "Node.js yükleme başarısız"

    fi
    echo -e "\\e[32m[ npm ]\\e[m önek yapılandırılıyor"
    mkdir -p "$HOME/.npm-packages"
    npm set prefix "$HOME/.npm-packages"

    echo -e "\\e[32m[ yarn ]\\e[m yükleniyor"
    if [ -d "$HOME/.yarn" ]; then
        echo -e "\\e[32m[ yarn ]\\e[m mevcut yarn kaldırılıyor"
        rm -rf "$HOME/.yarn"
    fi
    echo -e "\\e[32m[ yarn ]\\e[m nightly sürümü indiriliyor"
    curl -s -o- -L https://yarnpkg.com/install.sh | bash -s -- --nightly >/dev/null 2>&1
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
    echo -e "\\e[32m[ yarn ]\\e[m önek yapılandırılıyor"
    $HOME/.yarn/bin/yarn config set prefix "$HOME/.npm-packages" >/dev/null 2>&1
}

function install_requirements() {
    if ! [ -x "$(command -v git)" ]; then
        echo -e "\\e[32m[ git ]\\e[m bulunamadı, yükleniyor"
        pkg install -y git >/dev/null 2>&1
    fi

    if [ ! -d "$HOME/.local/bin" ]; then
        mkdir -p "$HOME/.local/bin"
        echo 'export PATH="$PATH:$HOME/.local/bin"' >> $HOME/.profile
    fi

    if [ ! -d "$HOME/.termux" ]; then
        curl -fsLo "$HOME/.termux/colors.properties" --create-dirs https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/colors.properties
        curl -fsLo "$HOME/.termux/font.ttf" --create-dirs https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/font.ttf
    fi
}

function install_postgres() {
    if ! [ -x "$(command -v pg_ctl)" ]; then
        echo -e "\\e[32m[ postgres ]\\e[m bulunamadı, yükleniyor"
        pkg install -y postgresql postgresql-dev >/dev/null 2>&1 && echo "PostgreSQL başarıyla yüklendi" || echo "PostgreSQL yükleme başarısız"
        echo -e "\\e[32m[ postgres ]\\e[m yapılandırmalar oluşturuluyor"
        initdb ~/.pg >/dev/null 2>&1
    fi

    if ! pg_ctl -D ~/.pg status >/dev/null 2>&1; then
        echo -e "\\e[32m[ postgres ]\\e[m başlatılıyor..."
        pg_ctl -D ~/.pg start >/dev/null 2>&1
    else
        echo -e "\\e[32m[ postgres ]\\e[m zaten çalışıyor."
    fi

    if ! createdb "$(whoami)" >/dev/null 2>&1; then
        echo -e "\\e[32m[ postgres ]\\e[m yeni veritabanı oluşturuluyor"
        createdb "$(whoami)"
    fi
}




function install_neovim() {
    if ! [ -x "$(command -v nvim)" ]; then
        echo -e "\\e[32m[ neovim ]\\e[m bulunamadı, yükleniyor"
        pkg install -y neovim >/dev/null 2>&1 && echo "Neovim başarıyla yüklendi" || echo "Neovim yükleme başarısız"

    fi
    if ! [ -x "$(command -v clang)" ]; then
        echo -e "\\e[32m[ neovim ]\\e[m clang bulunamadı, yükleniyor"
        pkg install -y clang libcrypt-dev >/dev/null 2>&1 && echo "Clang başarıyla yüklendi" || echo "Clang yükleme başarısız"
    fi
    if ! [ -x "$(command -v python)" ]; then
        echo -e "\\e[32m[ neovim ]\\e[m python bulunamadı, yükleniyor"
        pkg install -y python python-dev >/dev/null 2>&1
    fi
    pip3 install neovim >/dev/null 2>&1
    curl -fsLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/nvim/autoload/plug.vim
    curl -fsLo "$HOME/.config/nvim/colors/Tomorrow-Night-Eighties.vim" --create-dirs https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/nvim/colors/Tomorrow-Night-Eighties.vim
    curl -fsLo "$HOME/.config/nvim/init.vim" --create-dirs https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/nvim/init.vim
}

function install_ruby() {
    if ! [ -x "$(command -v ruby)" ]; then
        echo -e "\\e[32m[ ruby ]\\e[m bulunamadı, yükleniyor"
        pkg install -y ruby ruby-dev >/dev/null 2>&1 && echo "Ruby başarıyla yüklendi" || echo "Ruby yükleme başarısız"
    fi
    echo -e "\\e[32m[ ruby ]\\e[m pry yükleniyor"
    gem install pry >/dev/null 2>&1
}

function install_tmux() {
    if ! [ -x "$(command -v tmux)" ]; then
        echo -e "\\e[32m[ tmux ]\\e[m bulunamadı, yükleniyor"
        pkg install -y tmux >/dev/null 2>&1
    fi
    curl -fsLo "$HOME/.tmux.conf" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/.tmux.conf
}

function install_python() {
    if ! [ -x "$(command -v python)" ]; then
        echo -e "\\e[32m[ python ]\\e[m bulunamadı, yükleniyor"
        pkg install -y python python-dev >/dev/null 2>&1 && echo "Python başarıyla yüklendi" || echo "Python yükleme başarısız"
    fi
    curl -fsLo "$HOME/.pythonrc" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/.pythonrc
}

function install_php() {
    echo -e "\\e[32m[ php ]\\e[m bulunamadı, yükleniyor"
    pkg install -y nginx php php-fpm >/dev/null 2>&1 && echo "PHP ve Nginx başarıyla yüklendi" || echo "PHP ve Nginx yükleme başarısız"
}

function install_golang() {
    echo -e "\\e[32m[ go ]\\e[m bulunamadı, yükleniyor"
    pkg install -y golang >/dev/null 2>&1 && echo "Go başarıyla yüklendi" || echo "Go yükleme başarısız"
    # Dizin zaten mevcutsa yeniden oluşturma
    if [ ! -d "$HOME/.go" ]; then
        mkdir $HOME/.go
    fi

    echo 'export GOPATH="$HOME/.go"' >> $HOME/.profile
    echo 'export PATH="$PATH:$HOME/.go/bin"' >> $HOME/.profile
}

function start() {
    clear
    echo -e "\\n                :::!~!!!!!:."
    echo -e "                  .xUHWH!! !!?M88WHX:."
    echo -e "                .X*#M@$!!  !X!M$$$$$$WWx:."
    echo -e "               :!!!!!!?H! :!$!$$$$$$$$$$8X:"
    echo -e "              !!~  ~:~!! :~!$!#$$$$$$$$$$8X:"
    echo -e "             :!~::!H!<   ~.U$X!?R$$$$$$$$MM!"
    echo -e "             ~!~!!!!~~ .:XW$$$U!!?$$$$$$RMM!"
    echo -e "               !:~~~ .:!M\"T#$$$$WX??#MRRMMM!"
    echo -e "               ~?WuxiW*'   \`\"#$$$$8!!!!??!!!"
    echo -e "             :X- M$$$$       \`\"T#$T~!8$WUXU~"
    echo -e "            :% \`  ~#$$$m:        ~!~ ?$$$$$$"
    echo -e "          :!.-   ~T$$$$8xx.  .xWW- ~\"\"##*\""
    echo -e ".....   -~~:<\` !    ~?T#$$@@W@*?$$      /\\"
    echo -e "W$@@M!!! .!~~ !!     .:XUW$W!~ \`\"~:    :"
    echo -e "#\"~~\`.:x% !!  !H:   !WM$$$$Ti.: .!WUn+!\\"
    echo -e ":::~:!!\`:X~ .: ?H.!u \"\$$$B$$$!W:U!T$$M~"
    echo -e ".~~   :X@!.-~   ?@WTWo(\"*$$$W$TH$! \""
    echo -e "Wi.~!X$?!-~    : ?$$$B$Wu(\"**$RM!"
    echo -e "$R@i.~~ !     :   ~$$$$$B$$en:\`\`"
    echo -e "?MXT@Wx.~    :     ~\"##*$$$$M~"
    echo -e "              friday13 - ytoluyag@gmail.com"
    echo -e "              code - github.com/yuceltoluyag/termux.dot"
    check_root
    check_storage_permission
}

function finish() {
    termux-setup-storage
    touch "$HOME/.hushlogin"
    if ! grep -q "source ~/.profile" $HOME/.bash_profile >/dev/null 2>&1; then
        echo -e "\nif [ -f ~/.profile ]; then\n  source ~/.profile\nfi" >> "$HOME/.bash_profile"
    fi
    echo -e "\\e[32m[ tamamlandı ]\\e[m Ayarların uygulanması için lütfen Termux'u yeniden başlatın"
}

while [[ $# -gt 0 ]]; do
    case $1 in
    -e | --elixir)
        elixir=true
        ;;
    -g | --go | --golang)
        golang=true
        ;;
    -p | --python)
        python=true
        ;;
    -n | --nvim | --neovim)
        nvimrc=true
        ;;
    -js | --nodejs)
        nodejs=true
        ;;
    -t | --tmux)
        tmux=true
        ;;
    -r | --ruby)
        ruby=true
        ;;
    --php)
        php=true
        ;;
    -pg | --postgres)
        postgres=true
        ;;
    -z | --zsh)
        zsh=true
        ;;
    -a | --all)
        elixir=true
        golang=true
        python=true
        nvimrc=true
        nodejs=true
        tmux=true
        ruby=true
        php=true
        postgres=true
        zsh=true
        ;;
    *) echo -e "Bilinmeyen seçenek: $1" ;;
    esac
    shift
done

start
install_requirements

if [ "$python" = true ]; then
    install_python
fi

if [ "$zsh" = true ]; then
    install_zsh
fi

if [ "$nodejs" = true ]; then
    install_node
fi

if [ "$postgres" = true ]; then
    install_postgres
fi

if [ "$nvimrc" = true ]; then
    install_neovim
fi

if [ "$tmux" = true ]; then
    install_tmux
fi

if [ "$ruby" = true ]; then
    install_ruby
fi

if [ "$golang" = true ]; then
    install_golang
fi

if [ "$php" = true ]; then
    install_php
fi

if [ "$elixir" = true ]; then
    if ! [ -x "$(command -v erl)" ]; then
        echo -e "\\e[32m[ erlang ]\\e[m bulunamadı, yükleniyor"
        pkg install -y erlang >/dev/null 2>&1
    fi
    if [ ! -d "$HOME/.elixir" ]; then
        echo -e "\\e[32m[ elixir ]\\e[m kuruluyor..."
        install_elixir
    fi
fi

source $HOME/.profile
echo -e "\\e[33m[ UYARI ]\\e[m Bu değişikliklerin uygulanması için yeni bir oturum açmanız gerekebilir."

finish

exit
