#!/bin/bash

SESSION="dawbodem"

if pgrep -xo "tmux: server" >/dev/null && [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  if [ "$TERM_PROGRAM" = tmux ]; then
    tmux switch-client -t $SESSION
  else
    tmux attach -t $SESSION
  fi
  exit 1
fi

SESSION_PATH="$REMOTE_REPOS_PATH/dawbodem"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'sshfs s2-dawbodem:/home/dawbodem/domains/dev.daw-bodem.nl/application /home/tim/repos-remote/dawbodem -o cache=yes,kernel_cache,compression=no -v'

WINDOW="commander"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH
sleep 0.3
tmux send -t $SESSION:$WINDOW.1 'git status'

WINDOW="dev"

tmux new-window -n $WINDOW -t $SESSION
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-dawbodem'

WINDOW="prod"

tmux new-window -n $WINDOW -t $SESSION
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh s2-dawbodem'

if [ "$TERM_PROGRAM" = tmux ]; then
  tmux switch-client -t $SESSION
else
  tmux attach -t $SESSION
fi
