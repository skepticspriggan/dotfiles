#!/usr/bin/env bash

set -euxo pipefail

awk -v date="$(date +'%F')" '$1 < date { print$0 }' $NOTES_DIRECTORY/1-office/calendar-future.txt \
  | tee /tmp/to-past.txt \
  >> $NOTES_DIRECTORY/1-office/calendar-past.txt

if [ -s /tmp/to-past.txt ]; then
  #echo "" >> $NOTES_DIRECTORY/1-office/calendar-past.txt
  rm /tmp/to-past.txt
fi

awk -v date="$(date +'%F')" '$1 >= date { print$0 }' $NOTES_DIRECTORY/1-office/calendar-future.txt > /tmp/calendar-future.txt && mv /tmp/calendar-future.txt $NOTES_DIRECTORY/1-office/calendar-future.txt

