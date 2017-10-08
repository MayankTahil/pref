# General
export ZSH_CONF="~/.pref/zsh"
export PATH="~/.pref/bin:$PATH"
source $ZSH_CONF/.antigen.zsh
source $ZSH_CONF/.aliases.zsh

# Plugins
plugins=(git, brew, npm, zsh-completions, kubectl, brew, osx, extract, z)

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found

# Antigen Git Bundles
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell antigen that you're done.
antigen apply

# Theme
ZSH_THEME="senzshell"
