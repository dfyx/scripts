#!/bin/bash
PDESC=$(ps -A -o "pid args" | grep "$1" | grep -v grep | grep -v "$0")
if [ "$PDESC" == "" ]; then
  NUM=0
else
  NUM=$(echo "$PDESC" | wc -l)
fi

if [ $NUM -lt 1 ]; then
  echo "No matching processes found"
  exit 1
elif [ $NUM -gt 1 ]; then
  echo "Found $NUM processes:"
  echo
  IFS=$'\n'
  for PROCESS in $PDESC; do
    echo "$PROCESS" | sed -r 's/^([ 0-9]+) (.+)$/ \1 \2/'
  done
  unset IFS
  echo
  echo -n "Which one should I kill? [NONE/all/<num>] "
  read TOKILL

  if ([ "$TOKILL" == "" ] || [ "$TOKILL" == "NONE" ]); then
    exit 0
  elif [ "$TOKILL" == "ALL" ]; then
    IFS=$'\n'
    for PROCESS in $PDESC; do
      kill $(echo "$PROCESS" | sed 's/^ +//' | cut -d " " -f 1)
    done
    unset IFS
  else
    kill "$TOKILL"
  fi
else
  kill $(echo "$PDESC" | sed 's/^ +//' | cut -d " " -f 1)
fi
