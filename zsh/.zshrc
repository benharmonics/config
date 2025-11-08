unsetopt beep
bindkey -v

autoload -Uz compinit
compinit

# Plugins
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/chruby.sh # Or run `brew info chruby` to find out installed directory
source $HOMEBREW_PREFIX/opt/chruby/share/chruby/auto.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(uv generate-shell-completion zsh)"

function tmp()   { cd "$(mktemp -d)" }
function tmpmd() { tmp && nvim "${1:-tmp.md}" }

function generate-password() {
    local size=${1:-20}
    cat /dev/random | tr -dc '[:graph:]' | head -c$size
}

# Run a Docker image: a fresh setup of Ubuntu, able to access your current working directory
function workstation() {
  docker run --rm -it -v "$PWD":/work -w /work ubuntu:latest bash
}
# Run a Docker image: a fresh setup of Ubuntu with a non-root user, able to access your current working directory
function workstation-nonroot() {
  docker run --rm -it -v "$PWD":/work -w /work ubuntu-nonroot bash
}

alias note="nvim $HOME/Documents/Notes/note.md"
alias rr=ranger
alias ls=lsd
alias ll="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git clone'
alias gl="git log"
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'
alias gcm='git commit --message'
alias gpr='git pull --rebase'
alias gpsh='git push'
alias gsw='git switch'
alias gswc='git switch -c'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'
function gpurge() {
  git fetch -p && \
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

alias backup-notes='rsync -avh --exclude=".*" ~/Documents/Notes/ person@rpi.local:~/Documents/Notes'

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/benjiron/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/benjiron/.opam/opam-init/init.zsh' ]] || source '/Users/benjiron/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
