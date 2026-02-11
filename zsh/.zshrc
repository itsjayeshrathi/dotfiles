# ===========================================
# 1. Oh My Zsh
# ===========================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"


# ===========================================
# 2. Environment Variables
# ===========================================
# Go
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

# Homebrew (Linuxbrew)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Node (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# WSL browser helper
export BROWSER=/usr/local/bin/wsl-browser


# ===========================================
# 3. Modern CLI Tools
# ===========================================
# zoxide (smart cd)
eval "$(zoxide init zsh)"

# atuin (shell history)
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"


# ===========================================
# 4. Aliases
# ===========================================
alias cd="z"        # zoxide instead of cd
alias ls="eza"      # better ls


# ===========================================
# 5. ZSH Quality-of-Life
# ===========================================
# Edit current command in $EDITOR (Ctrl + X, Ctrl + E)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# Expand history when pressing space (!!, !$, etc.)
bindkey ' ' magic-space


# ===========================================
# 6. Auto Actions on Directory Change
# ===========================================
autoload -Uz add-zsh-hook

# Auto Python venv
auto_venv() {
  [[ -n "$VIRTUAL_ENV" ]] && return
  [[ -f .venv/bin/activate ]] && source .venv/bin/activate
}

# Auto nvm
auto_nvm() {
  [[ -f .nvmrc ]] && nvm use >/dev/null
}

add-zsh-hook chpwd auto_venv
add-zsh-hook chpwd auto_nvm


# ===========================================
# 7. File Extension Shortcuts
# ===========================================
alias -s json=jless
alias -s md=bat
alias -s txt=bat
alias -s log=bat
alias -s go='$EDITOR'
alias -s rs='$EDITOR'
alias -s py='$EDITOR'
alias -s js='$EDITOR'
alias -s ts='$EDITOR'


# ===========================================
# 8. Global Aliases
# ===========================================
alias -g NE='2>/dev/null'
alias -g NO='>/dev/null'
alias -g NUL='>/dev/null 2>&1'
alias -g J='| jq'


# ===========================================
# 9. zmv (Batch rename)
# ===========================================
autoload -Uz zmv
alias zcp='zmv -C'
alias zln='zmv -L'


# ===========================================
# 10. Directory Bookmarks
# ===========================================
hash -d dot=~/.dotfiles
hash -d dl=~/Downloads
hash -d proj=~/projects


# ===========================================
# 11. Git Hotkeys
# ===========================================
bindkey -s '^Xgc' 'git commit -m ""\C-b'
bindkey -s '^Xgp' 'git push origin '
bindkey -s '^Xgs' 'git status\n'
bindkey -s '^Xgl' 'git log --oneline -n 10\n'
