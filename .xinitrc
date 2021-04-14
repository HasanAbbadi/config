exec bspwm 
setxkbmap -option "caps:swapescape" 
wal -R 
poly 
lxappearance 
killall lxappearance 
autolock -time 5 -locker "systemctl suspend" -detectsleep
xrdb ~/.Xresources 
