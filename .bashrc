#
# ~/.bashrc
#

cd /home/hasan

# extract all types of files
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
# move to directory
jtd ()
{
	myDirec=$(find ~/.config -type d | sed 's+/home/hasan/.config/+ +g'| fzf --border=rounded --layout=reverse --prompt='<3) ' --color=light --preview='ls ~/.config' | sed 's+ +/home/hasan/.config/+g')

if [ -z $myDirec ]; then
	exit
fi
cd $1
}


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
wal -r && clear

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
