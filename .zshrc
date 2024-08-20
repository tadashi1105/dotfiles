#=============================================================================
# tadashi1105's .zshrc
#=============================================================================

# Plugins
# starship/starship
# Use Starship to customize prompt
eval "$(starship init zsh)"

# zsh-users/zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-users/zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-users/zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# ImageMagick
export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

# Set XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -l'
if command -v eza &> /dev/null; then
  alias ll='eza --long --group --icons --hyperlink'
  alias tree='eza --tree --icons --hyperlink'
  alias treel='ll --tree'
fi
alias lla='ll -a'
alias g='git'
alias lg='lazygit'
alias lgd='lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME'
# alias vim='nvim'
