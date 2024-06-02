# Misc
source $HOME/.cargo/env

# Plugins
export ZSH=$HOME/.config/zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Initializations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(pyenv init -)"

# Aliases
alias ls=lsd
alias ll="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
