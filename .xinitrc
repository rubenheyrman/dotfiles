#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#export DESKTOP_SESSION=plasma
#exec startplasma-x11
# Here kde is kept as default
session=${1:-kde}

case $session in
    kde               ) export DESKTOP_SESSION=plasma && exec startplasma-x11;; #plasma-desktop;
    bspwm	      ) setxkbmap us &
	    		$HOME/.screenlayout/double-monitor.sh
			eval\ \$\(/usr/bin/gnome-keyring-daemon\ --start\ --components\=pkcs11\,secrets\,ssh\)
			export\ SSH_AUTH_SOCK
	    		nitrogen --restore &
	   		xsetroot -cursor_name left_ptr 
			picom -f & 
			exec bspwm
			;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac
