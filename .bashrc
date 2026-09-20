#=============================================================================
# tadashi1105's .bashrc
#=============================================================================

# Use Starship to customize prompt
eval "$(starship init bash)"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"
