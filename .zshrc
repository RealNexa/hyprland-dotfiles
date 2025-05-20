export ZSH=$HOME/.zsh
ZSH_PLUGINS=$ZSH/plugins

# ZSH settings
setopt extendedglob
unsetopt beep
bindkey -v


# History file
HISTFILE=$HOME/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ulol21/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Plugins
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINS/git-prompt-zsh/git-prompt.zsh
fpath=($ZSH_PLUGINS/zsh-completions/src $fpath)

# Prompt
# PS1="[%B%n@%F{#2f8cc6}%m%f%b %1~ ]%(!.#.$) "
PROMPT='[%B%n@%F{#2f8cc6}%m%f%b %F{#26af9b}%1~%f $(gitprompt)]%(!.#.$) '


# Aliases
alias vim="nvim"
alias ls="ls --color"

# Environment variables
export EDITOR="nvim"


