#!/usr/bin/env bash
set -euo pipefail

zenity --question --text="Shutdown?" --width=200

if [ $? = 0 ]; then
    systemctl poweroff

else
    exit
fi
