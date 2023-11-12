#!/bin/bash

SESSION="rijnland"
SESSION_PATH="$REMOTE_REPOS_PATH/rijnland"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

tmux -2 new-session -d -s $SESSION -c $SESSION_PATH

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'sshfs s2-rijnland:/home/landbouwrijnland/domains/dev.landbouwportaalrijnland.nl/application /home/tim/repos-remote/rijnland -o cache=yes,kernel_cache,compression=no -v'

WINDOW="dev"

tmux new-window -n $WINDOW 
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'ssh s2-rijnland'

WINDOW="stage"

tmux new-window -n $WINDOW 
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'ssh s2-rijnland'

WINDOW="prod"

tmux new-window -n $WINDOW 
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'ssh s2-rijnland'

tmux attach -t $SESSION
