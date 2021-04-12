# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
cat ~/.cache/wal/sequences &

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# Aliases

# [Translate] aliases
alias enar='trans en:ar "$argv"'
alias aren='trans ar:en "$argv"'
alias enjpn='trans en:jpn "$argv"'
alias jpnen='trans jpn:en "$argv"'

# polybar aliases
alias lapo='bash ~/.config/polybar/launch.sh'
alias pywal='bash ~/.config/polybar/shapes/scripts/pywal.sh'
