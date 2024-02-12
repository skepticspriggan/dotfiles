#!/bin/bash

. tmux_exists.sh
. tmux_switch.sh

SESSION="lpnh"

if tmux_exists $SESSION; then
  tmux_switch $SESSION:1.1
  exit 1
fi

SESSION_PATH="$REMOTE_REPOS_PATH/lpnh"

tmux -2 new-session -d -s $SESSION -c $SESSION_PATH

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'sshfs s2-lpnh:/home/landbouwnh/domains/dev.landbouwportaalnoordholland.nl/application /home/tim/repos-remote/lpnh -o cache=yes,kernel_cache,compression=no -v'

WINDOW="dev"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-lpnh'

WINDOW="prod"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-lpnh'

tmux_switch $SESSION:1.1
