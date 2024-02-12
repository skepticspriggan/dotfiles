#!/bin/bash

#set -euxo pipefail

. tmux_exists.sh
. tmux_switch.sh

SESSION="qmk-firmware"
 
if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$REPOS_PATH/qmk_firmware"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.2
tmux send -t $SESSION:$WINDOW 'nvim keyboards/crkbd'

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.2
tmux send -t $SESSION:$WINDOW 'qmk compile -kb crkbd/rev1 -km skepticspriggan -e CONVERT_TO=elite_pi'


tmux_switch $SESSION:1.1
