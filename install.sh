#!/usr/bin/env bash



# Install ZSH plugins

# Autosuggestions
mkdir ./.zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ./.zsh/plugins/zsh-autosuggestions

# Zsh git prompt
mkdir ./.zsh/plugins/git-prompt-zsh
git clone --depth=1 https://github.com/woefe/git-prompt.zsh ./.zsh/plugins/git-prompt-zsh

# Zsh completions
mkdir ./.zsh/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-completions.git ./.zsh/plugins/zsh-completions
