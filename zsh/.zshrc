# Misc
source $HOME/.cargo/env
export PATH=$PATH:$HOME/go/bin
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Plugins
export ZSH=$HOME/.config/zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Initializations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(pyenv init -)"

# Aliases
alias note="nvim $HOME/Documents/Notes/note.md"
alias tmp="cd $(mktemp -d) && nvim tmp.md"
alias rr=ranger
alias ls=lsd
alias ll="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
