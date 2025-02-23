#!/bin/bash

. tmux_exists.sh
. tmux_switch.sh

SESSION="landbouwloket"

if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$REMOTE_REPOS_PATH/landbouwloket"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'sshfs s2-landbouwloket:/home/landbouwloket/domains/dev.landbouwloket.nl/application /home/tim/repos-remote/landbouwloket -o cache=yes,kernel_cache,compression=no -v'

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW.1 'git status'

WINDOW="dev"

tmux new-window -n $WINDOW -t $SESSION
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-landbouwloket'

WINDOW="prod"

tmux new-window -n $WINDOW -t $SESSION
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-landbouwloket'

tmux_switch $SESSION:1.1
