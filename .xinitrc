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
session=${1:-bspwm}

case $session in
    #kde          ) export DESKTOP_SESSION=plasma && exec startplasma-x11;; #plasma-desktop;
    bspwm	      ) setxkbmap us &
                    [[ -f ~/.config/X11/xprofile ]] && ~/.config/X11/xprofile
                    #$HOME/.screenlayout/double-monitor.sh
                    #$HOME/.screenlayout/double-monitor-home.sh
                    #$HOME/.screenlayout/double-monitor-frank-right.sh
                    #$HOME/.screenlayout/double-monitor-elias-right.sh
                    #$HOME/.screenlayout/double-monitor-home_left.sh
                    eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
                    export SSH_AUTH_SOCK
                    nitrogen --restore &
                    xsetroot -cursor_name left_ptr
                    picom -f --experimental-backend &
                    #picom -f --config ~/.config/picom/picom.conf &
                    dunst &
                    bluetoothctl power on &
                    mpd $HOME/.config/mpd/mpd.conf &
                    nm-applet &
                    [ -z $(pgrep -u $UID -x nextcloud) ] && nextcloud &
                    sh /usr/local/bin/battery-status.sh &
                    exec bspwm
                    ;;
    # No known session, try to run it as command
    *             ) exec $1;;
esac
