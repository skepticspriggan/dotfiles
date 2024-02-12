#!/bin/bash

. tmux_exists.sh
. tmux_switch.sh

SESSION="rijnland"

if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$REMOTE_REPOS_PATH/rijnland"

tmux -2 new-session -d -s $SESSION -c $SESSION_PATH

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3;
tmux send -t $SESSION:$WINDOW "sshfs s2-rijnland:/home/landbouwrijnland/domains/dev.landbouwportaalrijnland.nl/application $REMOTE_REPOS_PATH/rijnland -o cache=yes,kernel_cache,compression=no -v"

WINDOW="dev"

tmux new-window -n $WINDOW -t $SESSION:
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'ssh s2-rijnland'

WINDOW="stage"

tmux new-window -n $WINDOW -t $SESSION:
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'ssh s2-rijnland'

WINDOW="prod"

tmux new-window -n $WINDOW -t $SESSION:
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'ssh s2-rijnland'

tmux_switch $SESSION:1.1
