#!/bin/bash

# Check if port number or process name is supplied as argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <port_number or process_name> [<port_number or process_name> ...]"
  exit 1
fi

# Loop through all arguments provided
for arg in "$@"
do
  # Check if argument is a valid port number
  if [[ "$arg" =~ ^[0-9]+$ ]]; then
    # Find process ID listening on specified port
    pid=$(lsof -ti:$arg)

    # Check if process ID was found
    if [ -z "$pid" ]; then
      echo "No process found listening on port $arg"
    else
      # Kill the process listening on specified port
      kill -9 $pid
      echo "Process listening on port $arg has been killed"
    fi

  else
    # Find process ID with specified name
    pid=$(pgrep -f "$arg")

    # Check if process ID was found
    if [ -z "$pid" ]; then
      echo "No process found with name $arg"
    else
      # Kill the process with specified name
      kill -9 $pid
      echo "Process with name $arg has been killed"
    fi
  fi
done
