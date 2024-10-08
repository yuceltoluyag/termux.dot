#!/usr/bin/env zsh

local LAMBDA="%(?,%{$fg_bold[green]%}λ,%{$fg_bold[red]%}λ)"
if [[ "$USER" == "root" ]]; then USERCOLOR="red"; else USERCOLOR="green"; fi

# Git prompt bilgilerini kontrol eder ve uygun mesajı gösterir.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[blue]%}detached-head%{$reset_color%}) $(git_prompt_status)%{$fg[yellow]%}→ "
        else
            echo "$(git_prompt_info) $(git_prompt_status)%{$fg_bold[cyan]%}→ "
        fi
    else
        echo "%{$fg_bold[cyan]%}→ "
    fi
}

# Sağda gösterilecek git SHA bilgisini döndürür.
function get_right_prompt() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        echo -n "$(git_prompt_short_sha)%{$reset_color%}"
    else
        echo -n "%{$reset_color%}"
    fi
}

# Sol prompt yapılandırması
PROMPT='${LAMBDA}\
 %{$fg_no_bold[magenta]%}[%3~]\
 $(check_git_prompt_info)%{$reset_color%}'

# Sağ prompt yapılandırması
RPROMPT='$(get_right_prompt)'

# Git prompt bilgileri için format ayarları
ZSH_THEME_GIT_PROMPT_PREFIX="at %{$fg[blue]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✔"

# Git durum bilgisi sembolleri
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"

# Git branch'inin ileride olduğunu gösteren sembol
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg_bold[white]%}^"

# Git commit SHA gösterim ayarları
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg_bold[white]%}[%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$fg_bold[white]%}]"
