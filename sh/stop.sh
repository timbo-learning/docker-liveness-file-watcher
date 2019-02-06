#!/bin/bash - 

# Treat unset variables as errors
set -o nounset 

# Load common functions and constants
 source ./sh/shared.sh

main() {
  # Create the termination file
  touch $TERMINATE_FILE
  # Wait for the application to terminate graciously
  # ( When this script returns, docker/kubernetes
  # assumes it is safe to kill the container )
  # After the application has terminated, this
  # script will terminate as well.
  sleep 10m
}

main "$@"
