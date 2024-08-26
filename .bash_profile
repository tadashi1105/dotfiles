if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# Run tmux session manager script
if [ -f "$HOME/.scripts/tmux_session_manager" ]; then
  . "$HOME/.scripts/tmux_session_manager"
fi
