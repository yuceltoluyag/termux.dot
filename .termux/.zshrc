# Oh-My-Zsh Yolu
export ZSH=$HOME/.oh-my-zsh

# Tema
ZSH_THEME="lambda-mod"

# Varsayılan Metin Düzenleyici
VISUAL="nvim"
export EDITOR="$VISUAL"

# Eklentiler
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# Klasörler Arasında Gezinmek İçin Alias'lar
alias ..="cd .."  # Bir üst dizine çık
alias ...="cd ../.."  # İki üst dizine çık
alias ....="cd ../../.."  # Üç üst dizine çık
alias .....="cd ../../../.."  # Dört üst dizine çık

# Komut Alias'ları
alias cp="cp -rv"  # Kopyalama işlemlerini detaylı yap
alias rm="rm -rv"  # Silme işlemlerini detaylı yap
alias mv="mv -v"  # Taşıma işlemlerini detaylı yap

alias g="git"  # Git komutuna kısa yol
alias gh="hub"  # GitHub CLI için kısa yol

alias ka="kiall"  # Kullanıcı tanımlı alias
alias cl="clear"  # Terminali temizle
alias h="history"  # Komut geçmişini göster
alias q="exit"  # Terminal oturumunu kapat

# Ekstra Alias'lar
alias ll="ls -alF"  # Tüm dosyaları ayrıntılı listele
alias la="ls -A"  # Gizli dosyalar dahil tüm dosyaları listele
alias l="ls -CF"  # Klasörleri vurgulayarak listele

# Kaynak Dosyalar
source $HOME/.profile
source $ZSH/oh-my-zsh.sh

# Eğer başka bir yapılandırma dosyanız varsa, onu da kaynak olarak ekleyebilirsiniz:
# source $HOME/.zsh_custom
