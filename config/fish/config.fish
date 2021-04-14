# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
#cat ~/.cache/wal/sequences &

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences
function fish_mode_prompt; end
funcsave fish_mode_prompt
set fish_greeting

# Aliases

# [Translate] aliases
alias enar='trans en:ar "$argv"'
alias aren='trans ar:en "$argv"'
alias enjpn='trans en:jpn "$argv"'
alias jpnen='trans jpn:en "$argv"'

# polybar aliases
alias lapo='bash ~/.config/polybar/launch.sh'
alias pywal='bash ~/.config/polybar/shapes/scripts/pywal.sh'

# cd aliases
alias .='cd ..'
alias ..='cd .. && cd ..'
alias goto='cd (find ~/ -type d | fzf --border=rounded --layout=reverse --prompt "<3)" --color=dark --preview "ls ~/")'

# mpv aliases
alias mpv='mpv --hwdec=vaapi'
alias mpvimg='mpv --image-display-duration=inf'

# cp aliases
alias cpconf='cp $1 ~/rubbish/config/'

# git aliases
alias gc='git clone'
alias gp='git push'
alias gcm='git commit -m "$argv"'
