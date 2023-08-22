case $- in
  *i*) ;;
    *) return;;
esac

alias tf='terraform'
alias lg='lazygit'
alias k='kubectl'
alias kx='kubectx'


bw-search() {
    bw list items --search "$1" | jq
}

export OSH='$HOME/.oh-my-bash'
OSH_THEME="powerline"
OMB_USE_SUDO=true

completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

source "$OSH"/oh-my-bash.sh


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
