#!/usr/bin/env bash

set -euxo pipefail

grep "^x " $NOTES_DIRECTORY/1-office/tasks-todo.txt \
  | tee /tmp/to-done.txt \
  >> $NOTES_DIRECTORY/1-office/tasks-done.txt

if [ -s /tmp/to-done.txt ]; then
  #echo "" >> $NOTES_DIRECTORY/1-office/calendar-past.txt
  rm /tmp/to-done.txt
fi

grep "^x " -v $NOTES_DIRECTORY/1-office/tasks-todo.txt > /tmp/tasks-todo.txt && mv /tmp/tasks-todo.txt $NOTES_DIRECTORY/1-office/tasks-todo.txt
