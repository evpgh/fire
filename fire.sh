#!/bin/bash

function usage() {
  echo "Usage: $0 <port_number or process_name> [<port_number or process_name> ...]"
  exit 1
}

[[ $# -eq 0 ]] && usage

killed_count=0

for arg in "$@"; do
  if [[ "$arg" =~ ^[0-9]+$ ]]; then
    pids=$(lsof -ti:$arg)
    if [ -z "$pids" ]; then
      echo "No process found listening on port $arg 🧯"
    else
      for pid in $pids; do
        kill -9 $pid &>/dev/null
        ((killed_count++))
      done
    fi
  else
    pids=$(pgrep -f "$arg")
    if [ -z "$pids" ]; then
      echo "No process found with name $arg 🧯"
    else
      for pid in $pids; do
        kill -9 $pid &>/dev/null
        ((killed_count++))
      done
    fi
  fi
done

for ((i=0; i<killed_count; i++)); do
  echo -n "🔥"
done
echo ""

if [ $killed_count -gt 1 ]; then
  echo "$killed_count processes are no more."
else
  echo "The process is no more."
fi
