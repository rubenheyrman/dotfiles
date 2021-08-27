##!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# polybar topbar 2>&1 | tee -a /tmp/polybar1.log & disown
# polybar topbar_second 2>&1 | tee -a /tmp/polybar2.log & disown
polybar topbar -c ~/.config/polybar/pure_nordish.config 2>&1 | tee -a /tmp/polybar1.log & disown
polybar botbar -c ~/.config/polybar/pure_nordish.config 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."
