#!/bin/bash

SESSION="docsign"
SESSION_PATH="$REMOTE_REPOS_PATH/docsign"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  if [ "$TERM_PROGRAM" = tmux ]; then
    tmux switch-client -t $SESSION
  else
    tmux attach -t $SESSION
  fi
  exit 1
fi

tmux -2 new-session -d -s $SESSION -c $SESSION_PATH

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW "sshfs mx10-docsign-dev:/var/www/clients/client13/web22/web/application $REMOTE_REPOS_PATH/docsign -o cache=yes,kernel_cache,compression=no -v"

WINDOW="dev"

tmux new-window -n $WINDOW -t $SESSION:
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh mx10-docsign-dev'

WINDOW="stage"

tmux new-window -n $WINDOW -t $SESSION:
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh mx10-docsign-stage'

WINDOW="prod"

tmux new-window -n $WINDOW -t $SESSION:
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh mx10-docsign-prod'

if [ "$TERM_PROGRAM" = tmux ]; then
  tmux switch-client -t $SESSION
else
  tmux attach -t $SESSION
fi
