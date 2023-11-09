#!/bin/bash

SESSION="tobias-prod"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  tmux attach -t $SESSION
  exit 1
fi

SESSION_PATH="/var/www/clients/client4/web23/web"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:0 $WINDOW
tmux send -t $SESSION:$WINDOW 'vim .' ENTER

WINDOW="commander"

tmux new-window -n $WINDOW -c $SESSION_PATH

WINDOW="monitor"

tmux new-window -n $WINDOW -c $SESSION_PATH 
tmux send -t $SESSION:$WINDOW 'tail -f -n 200 ./logs/app.log | grep "error"' ENTER