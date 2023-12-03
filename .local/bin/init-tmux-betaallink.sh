#!/bin/bash

SESSION="betaallink"

if [[ -n "$(tmux ls | grep $SESSION)" ]]; then
  if [ "$TERM_PROGRAM" = tmux ]; then
    tmux switch-client -t $SESSION
  else
    tmux attach -t $SESSION
  fi
  exit 1
fi

SESSION_PATH="$REPOS_PATH/betaallink"
tmux -2 new-session -d -s $SESSION -c $SESSION_PATH 

WINDOW="editor"

tmux rename-window -t $SESSION:1 $WINDOW
sleep 0.3
tmux send -t $SESSION:$WINDOW 'nvim .'

WINDOW="commander"

tmux new-window -n $WINDOW -c $SESSION_PATH

tmux split-window -v -c $SESSION_PATH
tmux split-window -h -c $SESSION_PATH
tmux selectp -t 1
tmux split-window -h -c $WORK_SCRIPTS_PATH

sleep 0.3
tmux send -t $SESSION:$WINDOW.4 'sudo service docker start; cd .docker && ./run.sh'
tmux send -t $SESSION:$WINDOW.1 'git status'
tmux send -t $SESSION:$WINDOW.3 'docker exec -it php-apache /bin/bash'
tmux send -t $SESSION:$WINDOW.2 './deploy-betaallink-to-production.sh'

WINDOW="monitor"

tmux new-window -n $WINDOW -t $SESSION -c $SESSION_PATH 
sleep 0.3
tmux send -t $SESSION:$WINDOW 'docker exec -it php-apache /bin/bash -c "tail -f -n 100 /var/www/logs/app.log | grep "error""'

WINDOW="dev"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH 
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh mx10-betaallink-dev'

WINDOW="stage"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH 
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh mx10-betaallink-stage'

WINDOW="prod"

tmux new-window -n $WINDOW -t $SESSION: -c $SESSION_PATH 
sleep 0.3
tmux send -t $SESSION:$WINDOW 'ssh mx10-betaallink-prod'

if [ "$TERM_PROGRAM" = tmux ]; then
  tmux switch-client -t $SESSION
else
  tmux attach -t $SESSION
fi
