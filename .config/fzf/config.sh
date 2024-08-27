if [ -f "$HOME/.config/fzf/colors/tokyonight_moon.sh" ]; then
  . "$HOME/.config/fzf/colors/tokyonight_moon.sh"
fi

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --border \
  --tmux 80% \
"
