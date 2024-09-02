if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

if [ -f "$HOME/.scripts/startup" ]; then
  "$HOME/.scripts/startup"
fi
