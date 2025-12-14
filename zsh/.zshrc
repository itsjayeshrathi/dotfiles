export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export BROWSER=/usr/local/bin/wsl-browser


eval "$(zoxide init zsh)"

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"


source ~/dotfiles/zsh/.aliases
