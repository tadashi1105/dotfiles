# Run tmux session manager script
if [ -f "$HOME/.scripts/tmux_session_manager" ]; then
  # Do not execute at Warp Terminal startup, as keystrokes will be disabled.
  [[ $TERM_PROGRAM == "WarpTerminal" ]] && return
  "$HOME/.scripts/tmux_session_manager"
fi
