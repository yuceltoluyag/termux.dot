#!/data/data/com.termux/files/usr/bin/bash

elixir=false
golang=false
python=false
nvimrc=false
nodejs=false
tmux=false
ruby=false
php=false
zsh=false
install_nerd_font=true

function select_language() {
    echo "Select language / Dil seçiniz: "
    echo "1) English"
    echo "2) Türkçe"
    read -p "Choice (1 or 2): " lang_choice

    if [[ "$lang_choice" == "1" ]]; then
        LANG="en"
    else
        LANG="tr"
    fi
}

declare -A MESSAGES_EN=(
    ["warning"]="[ WARNING ]"
    ["install_warning"]="Some tasks may fail without root privileges."
    ["usage"]="Usage: install.sh [options]"
    ["available_options"]="Available options:"
    ["install_elixir"]="Install Elixir"
    ["install_golang"]="Install Go"
    ["install_python"]="Install Python"
    ["install_neovim"]="Install Neovim"
    ["install_nodejs"]="Install Node.js"
    ["install_tmux"]="Install Tmux"
    ["install_ruby"]="Install Ruby"
    ["install_lolcat"]="Lolcat not found, installing..."
    ["install_pry"]="Pry not found, installing..."
    ["already_installed"]="Already installed."
    ["install_php"]="Install PHP"
    ["install_erlang"]="Erlang not found, installing..."
    ["install_zsh"]="Install Zsh"
    ["install_all"]="Install all software"
    ["example"]="Example: ./install.sh --all"
    ["root_warning"]="No root privileges detected. Some tasks may fail without root."
    ["continue_prompt"]="Do you want to continue? (y/n): "
    ["installation_canceled"]="Installation canceled."
    ["root_detected"]="Root access detected."
    ["storage_exists"]="~/storage directory already exists."
    ["storage_prompt"]="Would you like to recreate the storage structure? (This may overwrite existing data) (y/n): "
    ["storage_setup"]="Setting up storage..."
    ["storage_not_reset"]="Storage structure not reset. Continuing..."
    ["storage_granted"]="Storage permission granted."
    ["install_completed"]="Installation completed."
    ["install_node"]="Node.js not found, installing..."
    ["install_python"]="Python not found, installing..."
    ["install_zsh"]="Zsh not found, installing..."
    ["install_elixir"]="Elixir not found, installing..."
    ["install_neovim"]="Neovim not found, installing..."
    ["installation_failed"]="Installation failed."
    ["installation_completed"]="Installation completed."
    ["unknown_option"]="Unknown option: "
    ["install_git"]="Git not found, installing..."
    ["install_curl"]="Curl not found, installing..."
    ["install_wget"]="Wget not found, installing..."
    ["install_nano"]="Nano not found, installing..."
    ["warning_restart"]="Please restart the session for the changes to take effect."
    ["install_nerd_font"]="Nerd fonts not found, installing..."
    ["select_option"]="Please select an option from the list:"
)

declare -A MESSAGES_TR=(
    ["warning"]="[ UYARI ]"
    ["install_warning"]="Root izni olmadan bazı işlemler başarısız olabilir."
    ["usage"]="Kullanım: install.sh [seçenekler]"
    ["available_options"]="Kullanılabilir seçenekler:"
    ["install_elixir"]="Elixir'i kur"
    ["install_golang"]="Go'yu kur"
    ["install_python"]="Python'ı kur"
    ["install_neovim"]="Neovim'i kur"
    ["install_nodejs"]="Node.js'i kur"
    ["install_tmux"]="Tmux'u kur"
    ["install_ruby"]="Ruby'yi kur"
    ["install_lolcat"]="Lolcat bulunamadı, yükleniyor..."
    ["install_pry"]="Pry bulunamadı, yükleniyor..."
    ["already_installed"]="Zaten yüklü."
    ["install_php"]="PHP'yi kur"
    ["install_erlang"]="Erlang bulunamadı, yükleniyor..."
    ["install_zsh"]="Zsh'i kur"
    ["install_all"]="Tüm yazılımları kur"
    ["example"]="Örnek: ./install.sh --all"
    ["root_warning"]="Root izni bulunmuyor. Root izni olmadan bazı işlemler başarısız olabilir."
    ["continue_prompt"]="Devam etmek istiyor musunuz? (E/h): "
    ["installation_canceled"]="Kurulum iptal edildi."
    ["root_detected"]="Root izni mevcut."
    ["storage_exists"]="~/storage dizini zaten mevcut."
    ["storage_prompt"]="Depolama yapısını yeniden oluşturmak istiyor musunuz? (Mevcut veriler üzerine yazılabilir) (E/h): "
    ["storage_setup"]="Depolama yapısı oluşturuluyor..."
    ["storage_not_reset"]="Depolama yapısı sıfırlanmadı. Devam ediliyor..."
    ["storage_granted"]="Depolama izni verildi."
    ["install_completed"]="Kurulum tamamlandı."
    ["install_node"]="Node.js bulunamadı, yükleniyor..."
    ["install_python"]="Python bulunamadı, yükleniyor..."
    ["install_zsh"]="Zsh bulunamadı, yükleniyor..."
    ["install_elixir"]="Elixir bulunamadı, yükleniyor..."
    ["install_neovim"]="Neovim bulunamadı, yükleniyor..."
    ["installation_failed"]="Yükleme başarısız oldu."
    ["installation_completed"]="Yükleme tamamlandı."
    ["unknown_option"]="Bilinmeyen seçenek: "
    ["install_git"]="Git bulunamadı, yükleniyor..."
    ["install_curl"]="Curl bulunamadı, yükleniyor..."
    ["install_wget"]="Wget bulunamadı, yükleniyor..."
    ["install_nano"]="Nano bulunamadı, yükleniyor..."
    ["warning_restart"]="Değişikliklerin etkili olması için oturumu yeniden başlatın."
    ["install_nerd_font"]="Nerd fontları bulunamadı, yükleniyor..."
    ["select_option"]="Listeden bir seçenek seçiniz:"
)

function get_message() {
    local key=$1
    local context=$2
    if [ "$LANG" == "en" ]; then
        if [ "$context" == "menu" ]; then
            case $key in
                install_elixir) echo "Elixir" ;;
                install_python) echo "Python" ;;
                install_golang) echo "Go" ;;
                install_neovim) echo "Neovim" ;;
                install_nodejs) echo "Node.js" ;;
                install_tmux) echo "Tmux" ;;
                install_ruby) echo "Ruby" ;;
                install_php) echo "PHP" ;;
                install_zsh) echo "Zsh" ;;
                install_all) echo "All Software" ;;
                *) echo "${MESSAGES_EN[$key]}" ;;
            esac
        else
            echo "${MESSAGES_EN[$key]}"
        fi
    else
        if [ "$context" == "menu" ]; then
            case $key in
                install_elixir) echo "Elixir" ;;
                install_python) echo "Python" ;;
                install_golang) echo "Go" ;;
                install_neovim) echo "Neovim" ;;
                install_nodejs) echo "Node.js" ;;
                install_tmux) echo "Tmux" ;;
                install_ruby) echo "Ruby" ;;
                install_php) echo "PHP" ;;
                install_zsh) echo "Zsh" ;;
                install_all) echo "Tüm Yazılımlar" ;;
                *) echo "${MESSAGES_TR[$key]}" ;;
            esac
        else
            echo "${MESSAGES_TR[$key]}"
        fi
    fi
}


select_language

function show_usage() {
    echo -e "\\e[32m$(get_message usage)\\e[m"
    echo -e "$(get_message available_options)"
    echo -e "  -e, --elixir        $(get_message install_elixir menu)"
    echo -e "  -g, --go, --golang  $(get_message install_golang menu)"
    echo -e "  -p, --python        $(get_message install_python menu)"
    echo -e "  -n, --nvim, --neovim $(get_message install_neovim menu)"
    echo -e "  -js, --nodejs       $(get_message install_nodejs menu)"
    echo -e "  -t, --tmux          $(get_message install_tmux menu)"
    echo -e "  -r, --ruby          $(get_message install_ruby menu)"
    echo -e "  --php               $(get_message install_php menu)"
    echo -e "  -z, --zsh           $(get_message install_zsh menu)"
    echo -e "  -a, --all           $(get_message install_all menu)"
    echo -e "\\e[31m$(get_message example)\\e[m"
}

if [ $# -eq 0 ]; then
    show_usage
    while true; do
        read -p "$(get_message 'select_option') " user_option
        if [[ "$user_option" =~ ^(-e|--elixir|-g|--go|--golang|-p|--python|-n|--nvim|--neovim|-js|--nodejs|-t|--tmux|-r|--ruby|--php|-z|--zsh|-a|--all)$ ]]; then
            set -- "$user_option"
            break
        else
            printf "\\e[31m%s\\e[m\\n" "$(get_message 'unknown_option') $user_option"
        fi
    done
fi

function check_root() {
    if [ "$EUID" -ne 0 ]; then
        printf "\\e[31m%s\\e[m %s\\n" "$(get_message 'warning')" "$(get_message 'install_warning')"
        read -p "$(get_message 'continue_prompt')" -n 1 -r
        echo    
        if [[ ! $REPLY =~ ^[YyEe]$ ]]; then
            printf "%s\\n" "$(get_message 'installation_cancelled')"
            exit 1
        fi
    else
        printf "\\e[32m[ Root ]\\e[m %s\\n" "$(get_message 'root_detected')"
    fi
}

function check_storage_permission() {
    if [ -d "$HOME/storage" ]; then
        printf "\\e[32m[ %s ]\\e[m %s\\n" "$(get_message 'storage_granted')" "$(get_message 'storage_exists')"
        read -p "$(get_message 'storage_prompt')" -n 1 -r
        echo   
        if [[ $REPLY =~ ^[YyEe]$ ]]; then
            termux-setup-storage
            printf "\\e[32m[ %s ]\\e[m %s\\n" "$(get_message 'storage_granted')" "$(get_message 'storage_setup')"
        else
            printf "\\e[33m%s\\e[m %s\\n" "$(get_message 'warning')" "$(get_message 'storage_warning')"
        fi
    else
        printf "\\e[32m[ %s ]\\e[m %s\\n" "$(get_message 'storage_granted')" "$(get_message 'storage_setup')"
        termux-setup-storage
    fi
}

function install_zsh() {
    install_package_if_needed zsh

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        printf "\\e[32m[ oh-my-zsh ]\\e[m %s\\n" "$(get_message storage_setup)"
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" --depth 1
    fi
    
    curl -fsLo "$HOME/.oh-my-zsh/themes/lambda-mod.zsh-theme" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/lambda-mod.zsh-theme
    curl -fsLo "$HOME/.zshrc" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/.zshrc
    curl -fsLo "$HOME/.profile" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/.profile
    
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
        printf "\\e[32m[ oh-my-zsh ]\\e[m %s\\n" "$(get_message install_zsh)"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting"
    fi
    
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
        printf "\\e[32m[ oh-my-zsh ]\\e[m %s\\n" "$(get_message install_node)"
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions"
    fi
    
    chsh -s zsh
    printf "\\e[32m[ Zsh ]\\e[m %s\\n" "$(get_message installation_completed)"
}

function install_elixir() {
    install_package_if_needed unzip

    mkdir -p "$HOME/.elixir" && cd "$HOME/.elixir" || exit

    printf "\\e[32m[ elixir ]\\e[m %s\\n" "$(get_message install_elixir)"
    curl -L https://github.com/elixir-lang/elixir/releases/download/v1.17.2/elixir-otp-27.zip -o elixir-otp-27.zip
    unzip -qq elixir-otp-27.zip && rm elixir-otp-27.zip
    cd bin || exit

    printf "\\e[32m[ elixir ]\\e[m %s\\n" "$(get_message storage_setup)"
    termux-fix-shebang elixir elixirc iex mix

    if ! grep -q 'export PATH="$PATH:$HOME/.elixir/bin"' "$HOME/.profile"; then
        echo 'export PATH="$PATH:$HOME/.elixir/bin"' >> "$HOME/.profile"
    fi
    export PATH="$PATH:$HOME/.elixir/bin"
    cd "$HOME" || exit
}


function install_node() {
    install_package_if_needed nodejs-lts

    node -v
    npm -v

    printf "\\e[32m[ npm ]\\e[m %s\\n" "$(get_message storage_setup)"
    mkdir -p "$HOME/.npm-packages"
    npm set prefix "$HOME/.npm-packages"

    printf "\\e[32m[ yarn ]\\e[m %s\\n" "$(get_message install_zsh)"
    if [ -d "$HOME/.yarn" ]; then
        printf "\\e[32m[ yarn ]\\e[m %s\\n" "$(get_message storage_not_reset)"
        rm -rf "$HOME/.yarn"
    fi
    
    printf "\\e[32m[ yarn ]\\e[m %s\\n" "$(get_message install_elixir)"
    curl -s -o- -L https://yarnpkg.com/install.sh | bash -s -- --nightly 2>&1
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
    
    printf "\\e[32m[ yarn ]\\e[m %s\\n" "$(get_message storage_setup)"
    $HOME/.yarn/bin/yarn config set prefix "$HOME/.npm-packages" 2>&1
}

function get_message_safe() {
    local key=$1
    local message
    
    if [ "$LANG" == "en" ]; then
        message="${MESSAGES_EN[$key]}"
    else
        message="${MESSAGES_TR[$key]}"
    fi

    if [ -z "$message" ]; then
        message="Installing $key..."
    fi
    
    echo "$message"
}

function install_package_if_needed() {
    local package_name=$1
    local message_key="install_${package_name}"
    
    if ! [ -x "$(command -v $package_name)" ]; then
        printf "\\e[32m[ %s ]\\e[m %s\\n" "$package_name" "$(get_message_safe $message_key)"
        if pkg install -y "$package_name" > /dev/null 2>&1; then
        printf "\\e[32m%s\\n" "$(get_message install_completed)"
        else
            printf "\\e[31m%s\\n" "$(get_message installation_failed)" >&2
        fi
    fi
}

function install_requirements() {
    required_packages=(
        git
        curl
        wget
        nano
        vim
        clang
        libcrypt
        zip
        unzip
        nmap
        openssh
        tmux
        ffmpeg
        imagemagick
        build-essential
        binutils
        pkg-config
        python3
        cmatrix
        figlet
        cowsay
        toilet
        gnupg
        net-tools
        w3m
    )
    
    printf "\\e[32m[ %s ]\\e[m %s\\n" "$(get_message install_all)" "$(get_message storage_setup)"
    pkg update -y && pkg upgrade -y

    for package in "${required_packages[@]}"; do
        install_package_if_needed "$package"
    done

    if [ ! -d "$HOME/.local/bin" ]; then
        mkdir -p "$HOME/.local/bin"
        echo 'export PATH="$PATH:$HOME/.local/bin"' >> "$HOME/.profile"
    fi

    if [ ! -d "$HOME/.termux" ]; then
        curl -fsLo "$HOME/.termux/colors.properties" --create-dirs https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/colors.properties
    fi
}

function install_neovim() {
    install_package_if_needed neovim

    if [ -d "$HOME/.config/nvim" ]; then
        printf "\\e[32m[ Neovim ]\\e[m %s\\n" "$(get_message storage_not_reset)"
        rm -rf "$HOME/.config/nvim"
    fi
    if [ -d "$HOME/.local/state/nvim" ]; then
        rm -rf "$HOME/.local/state/nvim"
    fi
    if [ -d "$HOME/.local/share/nvim" ]; then
        rm -rf "$HOME/.local/share/nvim"
    fi

    printf "\\e[32m[ NvChad ]\\e[m %s\\n" "$(get_message install_neovim)"
    git clone https://github.com/NvChad/starter ~/.config/nvim
    
    rm -rf ~/.config/nvim/.git
}

function install_nerd_font() {
    if ! [ -x "$(command -v termux-nerd-installer)" ]; then
        printf "\\e[32m[ termux-nerd-installer ]\\e[m %s\\n" "$(get_message install_nerd_font)"
        git clone https://github.com/notflawffles/termux-nerd-installer.git
        cd termux-nerd-installer || exit 1
        make install
        cd ..
        rm -rf termux-nerd-installer
    else
        printf "\\e[32m[ termux-nerd-installer ]\\e[m %s\\n" "$(get_message install_nerd_font)"
    fi

    termux-nerd-installer install fira-code
    termux-nerd-installer set fira-code
    termux-nerd-installer list available
}

function install_ruby() {
    install_package_if_needed ruby

    printf "\\e[32m[ Ruby ]\\e[m %s\\n" "$(get_message install_ruby)"
    if ! gem list -i lolcat > /dev/null 2>&1; then
        printf "\\e[32m[ lolcat ]\\e[m %s\\n" "$(get_message 'install_lolcat')"
        if gem install lolcat 2>&1; then
            printf "\\e[32m%s\\e[m\\n" "$(get_message 'install_completed')"
        else
            printf "\\e[31m%s\\e[m\\n" "$(get_message 'installation_failed')"
        fi
    else
        printf "\\e[32m[ lolcat ]\\e[m %s\\n" "$(get_message 'already_installed')"
    fi

    if ! gem list -i pry > /dev/null 2>&1; then
        printf "\\e[32m[ pry ]\\e[m %s\\n" "$(get_message 'install_pry')"
        if gem install pry 2>&1; then
            printf "\\e[32m%s\\e[m\\n" "$(get_message 'install_completed')"
        else
            printf "\\e[31m%s\\e[m\\n" "$(get_message 'installation_failed')"
        fi
    else
        printf "\\e[32m[ pry ]\\e[m %s\\n" "$(get_message 'already_installed')"
    fi
}


function install_tmux() {
    install_package_if_needed tmux
    
    printf "\\e[32m[ Tmux ]\\e[m %s\\n" "$(get_message install_neovim)"
    curl -fsLo "$HOME/.tmux.conf" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/.tmux.conf
}

function install_python() {
    install_package_if_needed python

    curl -fsLo "$HOME/.pythonrc" https://raw.githubusercontent.com/yuceltoluyag/termux.dot/main/.termux/.pythonrc
}

function install_php() {
    install_package_if_needed nginx
    install_package_if_needed php
    install_package_if_needed php-fpm
}

function install_golang() {
    install_package_if_needed golang

    mkdir -p "$HOME/.go"

    if ! grep -q 'export GOPATH="$HOME/.go"' "$HOME/.profile"; then
        echo 'export GOPATH="$HOME/.go"' >> "$HOME/.profile"
    fi

    if ! grep -q 'export PATH="$PATH:$HOME/.go/bin"' "$HOME/.profile"; then
        echo 'export PATH="$PATH:$HOME/.go/bin"' >> "$HOME/.profile"
    fi

    export PATH="$PATH:$HOME/.go/bin"  
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
    touch "$HOME/.hushlogin"

    if [ -f "$HOME/.bash_profile" ]; then
        if ! grep -q "source ~/.profile" "$HOME/.bash_profile" 2>&1; then
            printf "\nif [ -f ~/.profile ]; then\n  source ~/.profile\nfi\n" >> "$HOME/.bash_profile"
        fi
    else
        touch "$HOME/.bash_profile"
        printf "\nif [ -f ~/.profile ]; then\n  source ~/.profile\nfi\n" >> "$HOME/.bash_profile"
    fi

    if [ -f "$HOME/.zshrc" ]; then
        if ! grep -q "source ~/.profile" "$HOME/.zshrc"; then
            echo 'if [ -f ~/.profile ]; then source ~/.profile; fi' >> "$HOME/.zshrc"
        fi
    fi

    printf "\\e[32m[ %s ]\\e[m %s\\n" "$(get_message install_completed)" "$(get_message installation_completed)"
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
        zsh=true
        ;;
    *)
        printf "\\e[31m%s\\e[m\\n" "$(get_message 'unknown_option') $1"
        ;;
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

if [ "$nvimrc" = true ]; then
    install_neovim
    install_nerd_font
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
    install_package_if_needed erlang
    fi

    if [ ! -d "$HOME/.elixir" ]; then
        printf "\\e[32m[ Elixir ]\\e[m %s\\n" "$(get_message 'install_elixir')"
        install_elixir
    fi
fi

source "$HOME/.profile"
printf "\\e[33m[ %s ]\\e[m\\n" "$(get_message 'warning_restart')"

finish

exit
