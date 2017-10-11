# General
export PATH="~/.pref/bin:$PATH"
source ~/.pref/zsh/.antigen.zsh
source ~/.pref/zsh/.aliases.zsh
export fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# Plugins
plugins=(git brew npm zsh-completions kubectl brew osx extract z)

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle webyneter/docker-aliases.git
antigen bundle desyncr/auto-ls

# Antigen Git Bundles
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell antigen that you're done.
antigen apply

# Theme
ZSH_THEME="senzshell"
