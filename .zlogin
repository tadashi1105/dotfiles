# Do not run in VSCode's integrated terminal
[ -n "$VSCODE_PID" ] && return
[ "x$TERM_PROGRAM" = "xvscode" ] && return

if [ -f "$HOME/.scripts/startup" ]; then
  "$HOME/.scripts/startup"
fi
