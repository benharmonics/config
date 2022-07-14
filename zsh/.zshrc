# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ben/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export ZSH=/home/ben/.config/zsh
# Plugins
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Cargo bins
source $HOME/.cargo/env
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Personal aliases
alias chwall=$HOME/.local/scripts/random_wallpaper/script.sh
alias ls=exa
alias ll="exa -l"

# AppImage aliases
alias musescore=$HOME/AppImages/MuseScore-3.6.2.AppImage
alias etcher=$HOME/AppImages/balenaEtcher-1.7.9-x64.AppImage
