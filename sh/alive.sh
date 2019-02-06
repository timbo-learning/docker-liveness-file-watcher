#!/bin/bash 

# Treat unset variables as an error
set -o nounset                              

# Load common functions and constants
source ./sh/shared.sh

# List of errors
ERR_NOT_ALIVE=1

# If it has been $alive_window seconds since $alive_time
# has been updated, the application is
# considered unresponsive/not working and will be
# killed.
main() {
  read_alive_time
  now=$(unix_time_in_seconds)
  if (( now - alive_time >= alive_window )); then
    echo "alive.sh: Not alive"
    exit $ERR_NOT_ALIVE
  fi
  echo "alive.sh: alive"

  exit 0
}

main "$@"
