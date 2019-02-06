#!/bin/bash

source scripts/shared.sh

refresh() {
  read_alive_time
  now=$(unix_time_in_seconds)
  elapsed=$(( now - alive_time ))
  
  # Only refresh if it has been some time.
  # we dont want to write to file every single iteration.
  if (( elapsed >= REFRESH_TIME )); then
    
    if (( elapsed >= alive_window )); then
      # Too much time not responding, stop
      echo "watch:warning: took too long to update"
    fi
      refresh_alive_time $ALIVE_WINDOW
  fi
}

work() {
  # Do some work,
  # here emulated by sleeping
  _sleep
}

_sleep() {
  echo Sleeping for $sleep_time
  sleep $sleep_time
  # After 4 times, sleep longer
  # to emulate unresponsiveness.
  if [[ $times_refreshed -ge 4 ]]; then
    sleep_time=$((3*REFRESH_TIME))
  fi
}
main() {
		while true; do
    if [ -f "$TERMINATE_FILE" ] ; then
      delete_terminate_file
      break
    fi

    refresh
    work
  done
  echo "watch.sh terminating"
}


main "$@"
