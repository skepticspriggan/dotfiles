#!/bin/env bash

# set -euxo pipefail

date_pattern="^[0-9]{4}-[0-9]{2}-[0-9]{2} w[0-9]* (Mon|Tue|Wed|Thu|Fri|Sat|Sun)+"
week_pattern="^[0-9]{4}-[0-9]{2}-[0-9]{2} w[0-9]*"

last_date=""

awk -v start="$(date +'%F')" \
  -v end="$(date -d '+5 weeks' +'%F')" \
  '$1 > start && $1 < end { print$0 }' $NOTES_DIRECTORY/1-office/calendar.txt \
  | while read date; do
  echo -n $date
  awk -v start="$(date +'%F')" \
    -v end="$(date -d '+5 weeks' +'%F')" \
    '$1 < end && $1 > start { print$0 }' $NOTES_DIRECTORY/1-office/events-onetime.txt \
    | while read event; do
    if echo $event | grep -qE "$date_pattern"; then
      event_date=$(echo $event | grep -oE "$date_pattern")
      padding=""
    elif echo $event | grep -qE "$week_pattern"; then
      event_date=$(echo $event | grep -oE "$week_pattern")
      padding="    "
    fi
    if [[ $date == $event_date ]]; then
      event_description_position=$(("${#event_date}" + 1))
      event_description="${event:$event_description_position}"
      if [[ $date == $last_date ]]; then
        echo -n "; $event_description"
      else
        echo -n "$padding $event_description"
      fi
      last_date=$event_date
    fi
  done
  echo
done

# echo "2024-05-12 w19 Sun xx" | grep -E "$date_pattern"
# echo "2024-05-12 w19 xx" | grep -E "$week_pattern"
