#!/bin/bash

function usage() {
  echo "Usage: $0 <port_number or process_name> [<port_number or process_name> ...]"
  exit 1
}

function animate_string() {
  local string="$1"
  
  for (( i=1; i<=${#string}; i++ )); do
    local char="${string:i-1:1}"
    printf "\r%s" "${string:0:i}"
    tput setaf 1; printf "🔥"; tput sgr0
    sleep 0.03
    printf "\r"; tput setaf 1; printf "%s" "${string:0:i}"; tput sgr0
    sleep 0.03
    tput setaf 1; printf "%s" "$char"; tput sgr0
  done
  
  printf "\r"; tput setaf 1; printf "%s" "$string"; tput sgr0; printf "\n"
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

if [ $killed_count -gt 0 ]; then
  sleep 0.2
  if [ $killed_count -gt 1 ]; then
    animate_string " $killed_count processes are no more. "
  else
    animate_string " The process is no more. "
  fi
fi
