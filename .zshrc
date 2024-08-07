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

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# Aliases
alias ls='ls --color=auto'
alias ll='ls -l'
if command -v eza &> /dev/null; then
  alias ll='eza --long --group --icons'
fi
alias g='git'
# alias vim='nvim'
