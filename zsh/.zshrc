export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# Environment
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

export BROWSER=/usr/local/bin/wsl-browser

# Tools
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Aliases
[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"

# Key bindings
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey ' ' magic-space

bindkey -s '^Xgc' 'git commit -m ""\C-b'
bindkey -s '^Xgp' 'git push origin '
bindkey -s '^Xgs' 'git status\n'
bindkey -s '^Xgl' 'git log --oneline -n 10\n'

# Directory bookmarks
hash -d dot=~/.dotfiles
hash -d dl=~/Downloads
hash -d proj=~/projects

# Batch rename
autoload -Uz zmv
alias zcp='zmv -C'
alias zln='zmv -L'

# Auto venv + nvm on directory change
autoload -Uz add-zsh-hook

auto_venv() {
  [[ -n "$VIRTUAL_ENV" ]] && return
  [[ -f .venv/bin/activate ]] && source .venv/bin/activate
}

auto_nvm() {
  [[ -f .nvmrc ]] && nvm use >/dev/null
}

add-zsh-hook chpwd auto_venv
add-zsh-hook chpwd auto_nvm

