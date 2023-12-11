#!/bin/bash

SESSION="statusportaal"
SESSION_PATH="$REMOTE_REPOS_PATH/statusportaal"

if pgrep -xo "tmux: server" >/dev/null && [[ -n "$(tmux ls | grep $SESSION)" ]]; then
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
sleep 0.3;
tmux send -t $SESSION:$WINDOW "sshfs mx10-statusportaal-dev:/var/www/clients/client11/web4/web/application $REMOTE_REPOS_PATH/statusportaal -o cache=yes,kernel_cache,compression=no -v"

WINDOW="dev"

tmux new-window -n $WINDOW -t $SESSION:
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'ssh mx10-statusportaal-dev'

WINDOW="stage"

tmux new-window -n $WINDOW -t $SESSION:
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'ssh mx10-statusportaal-stage'

WINDOW="prod"

tmux new-window -n $WINDOW -t $SESSION:
sleep 0.3;
tmux send -t $SESSION:$WINDOW 'ssh mx10-statusportaal-prod'

if [ "$TERM_PROGRAM" = tmux ]; then
  tmux switch-client -t $SESSION
else
  tmux attach -t $SESSION
fi
