# Hasan's config of the zsh shell
#

autoload -U colors && colors
PS1="%~%\ ⟩%b "

export HISTFILE=~/.cache/zsh/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
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
                                         bindkey -s '^o' 'lfcd\n'

alias ls='ls --color=auto'

# Edit line in vim with ctrl-e:
 autoload edit-command-line; zle -N edit-command-line
 bindkey '^e' edit-command-line

 # Load zsh-suggestions
 source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

 # Load zsh-syntax-highlighting; should be last.
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
 
# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
