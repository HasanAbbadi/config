# I use arch btw
randomfetch 
# Hasan's config of the zsh shell
#
source ~/.zprofile

alias v='vim'
alias sps='sudo pacman -S'
alias clr="clear && zsh"
alias ls='ls --color=always'
#alias ls='lsd'
alias chlay='bsp-layout set'
alias downman="mangadl -r -d ~/manga/ $1" 
# Aliases

# [Translate] aliases
alias enar="trans en:ar "$1""
alias aren="trans ar:en "$1""
alias enjpn="trans en:jpn "$1""
alias jpnen="trans jpn:en "$1""

# polybar aliases
alias lapo='bash ~/.config/polybar/launch.sh'
alias pywal='bash ~/.config/polybar/shapes/scripts/pywal.sh'

# cd aliases
alias .='cd ..'
alias ..='cd .. && cd ..'
alias goto='cd $(find ~/ -type d | fzf --border=rounded --layout=reverse --prompt "<3)" --color=dark --preview "ls ~/")'

# mpv aliases
alias mpv='mpv --hwdec=vaapi'
alias mpvimg='mpv --image-display-duration=inf'

# cp aliases
alias cpconf='cp $1 ~/rubbish/config/'

# git aliases
alias gc='git clone'
alias gp='git push'
alias gcm='git commit -m'

####################################################################

PS1="%~%\ ⟩%b "

export HISTFILE=~/.cache/zsh/history
export HISTSIZE=100000
export SAVEHIST=100000
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY

autoload -U compinit
zstyle ':completion*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

#Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


#change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
	       [[ $1 = 'block' ]]; then
      echo -ne '\e[1 q'
        elif [[ ${KEYMAP} == main ]] ||
		       [[ ${KEYMAP} == viins ]] ||
		              [[ ${KEYMAP} = '' ]] ||
			             [[ $1 = 'beam' ]]; then
	    echo -ne '\e[5 q'
	      fi
      }
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
        echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.



# Use lf to switch directories and bind it to ctrl-o
 lfcd () {
     tmp="$(mktemp)"
         lf -last-dir-path="$tmp" "$@"
             if [ -f "$tmp" ]; then
                     dir="$(cat "$tmp")"
                             rm -f "$tmp"
                                     [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
                                         fi
                                         }
                                         bindkey -s '^o' 'ranger\n'


# Edit line in vim with ctrl-e:
 autoload edit-command-line; zle -N edit-command-line
 bindkey '^e' edit-command-line

 # Load zsh-suggestions
 source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

 # Load colored man pages
 source ~/.zsh/colored-man-pages/colored-man-pages.plugin.zsh
 # Load zsh-syntax-highlighting; should be last.
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
 
# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.zsh_history
HISTSIZE=100000
SAVEHIST=100000


PATH="/home/hasan/.mangadl-bash:${PATH}"
