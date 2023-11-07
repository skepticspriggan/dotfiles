#!/bin/bash
SOURCE_DIRECTORY="/media/tim/v-ssd-tran/notes"
BACKUP_DIRECTORY="/media/tim/d-sam-ssd-500/backup/notes"
YEAR=$(date +'%Y')
MONTH=$(date +'%m')
DAY=$(date +'%d')

BACKUP_DAY_DIRECTORY="${BACKUP_DIRECTORY}/notes-${YEAR}-${MONTH}-${DAY}"
cp -r $SOURCE_DIRECTORY $BACKUP_DAY_DIRECTORY

BACKUP_MONTH_DIRECTORY="${BACKUP_DIRECTORY}/notes-${YEAR}-${MONTH}"
cp -r $SOURCE_DIRECTORY $BACKUP_MONTH_DIRECTORY

BACKUP_YEAR_DIRECTORY="${BACKUP_DIRECTORY}/notes-${YEAR}"
cp -r $SOURCE_DIRECTORY $BACKUP_YEAR_DIRECTORY

# delete daily backups from before one month ago
LAST_MONTH=$(date -I -d "$DATE - 1 month")
LAST_MONTH_YEAR=$(date -d "$LAST_MONTH" +'%Y')
LAST_MONTH_MONTH=$(date -d "$LAST_MONTH" +'%m')
LAST_MONTH_DAY=$(date -d "$LAST_MONTH" +'%d')

for Y in $(seq -f "%02g" 2020 $LAST_MONTH_YEAR)
do
  if [ $Y == $LAST_MONTH_YEAR ]; then
    END_MONTH=$LAST_MONTH_MONTH;
  else
    END_MONTH=12;
  fi
  for M in $(seq -f "%02g" 1 $END_MONTH)
  do
    if [ $M == $LAST_MONTH_MONTH ]; then
      END_DAY=$LAST_MONTH_DAY;
    else
      END_DAY=31;
    fi
    for D in $(seq -f "%02g" 01 $END_DAY); do
      DELETE_DAY_DIRECTORY="${BACKUP_DIRECTORY}/notes-${Y}-${M}-${D}"
      #rm -Rf $DELETE_DAY_DIRECTORY
      #echo $DELETE_DAY_DIRECTORY
    done
  done
done

# delete monthly backups from before one year ago
LAST_YEAR=$(date -I -d "$DATE - 1 year")
LAST_YEAR_YEAR=$(date -d "$LAST_YEAR" +'%Y')
LAST_YEAR_MONTH=$(date -d "$LAST_YEAR" +'%m')
LAST_YEAR_DAY=$(date -d "$LAST_YEAR" +'%d')

for Y in $(seq -f "%02g" 2019 $LAST_YEAR_YEAR)
do
  if [ $Y == $LAST_YEAR_YEAR ]; then
    END_MONTH=$LAST_YEAR_MONTH;
  else
    END_MONTH=12;
  fi
  for M in $(seq -f "%02g" 1 $END_MONTH)
  do
    DELETE_MONTH_DIRECTORY="${BACKUP_DIRECTORY}/notes-${Y}-${M}"
    #rm -Rf $DELETE_MONTH_DIRECTORY
    #echo $DELETE_MONTH_DIRECTORY
  done
done
