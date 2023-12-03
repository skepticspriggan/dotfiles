#!/bin/bash

SESSION="dawbodem"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

SESSION_PATH="$REMOTE_REPOS_PATH/dawbodem"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'sshfs s2-dawbodem:/home/dawbodem/domains/dev.daw-bodem.nl/application /home/tim/repos-remote/dawbodem -o cache=yes,kernel_cache,compression=no -v'

WINDOW="commander"

tmux new-window -n $WINDOW -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW.1 'git status'

WINDOW="dev"

tmux new-window -n $WINDOW 
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-dawbodem'

WINDOW="prod"

tmux new-window -n $WINDOW 
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-dawbodem'

tmux attach -t $SESSION
