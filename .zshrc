#=============================================================================
# tadashi1105's .zshrc
#=============================================================================

# Environment Variables

# Set the config home directory in compliance with XDG Base Directory Specification
# Use the existing value if set, otherwise use the default
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Set the library path for ImageMagick
# This ensures that ImageMagick functions can be used correctly
export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

# Plugins

# starship: Set up a customizable and responsive prompt
eval "$(starship init zsh)"

# zsh-autosuggestions: Display command suggestions while typing
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting: Enable syntax highlighting for shell command input
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zsh-completions: Load additional completion definitions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

# fzf: Fuzzy finder
source <(fzf --zsh)
if [ -f "$XDG_CONFIG_HOME/fzf/config.sh" ]; then
  . "$XDG_CONFIG_HOME/fzf/config.sh"
fi

# zoxide: Initialize the tool that serves as a smarter alternative to the 'cd' command
eval "$(zoxide init zsh)"

# Aliases

alias ls='ls --color=auto'
alias ll='ls -l'

if command -v eza &> /dev/null; then
  alias ll='eza --long --header --group --git --icons --hyperlink'
  alias llt='ll --tree'
  alias lt='eza --tree --icons --hyperlink'
  alias tree='lt'
fi

alias lla='ll -a'
alias g='git'
alias lg='lazygit'
alias lgd='lazygit --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
# alias vim='nvim'
