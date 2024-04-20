#!/bin/bash

. tmux_exists.sh
. tmux_switch.sh

SESSION="opinionfirst"

if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$REMOTE_REPOS_PATH/opinionfirst"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'sshfs s3-opinionfirst:/home/opinionfirst/domains/dev.opinionfirst.com/application /home/tim/repos-remote/opinionfirst -o cache=yes,kernel_cache,compression=no -v'

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW.1 'git status'

WINDOW="dev"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s3-opinionfirst'

WINDOW="prod"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s3-opinionfirst'

tmux_switch $SESSION:1.1
