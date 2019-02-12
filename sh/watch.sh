#!/bin/bash

source sh/shared.sh

TIMES_TO_TURN_UNRESPONSIVE=30
DELAY_BEFORE_TERMINATION=10

refresh() {
  read_alive_time
  now=$(unix_time_in_seconds)
  elapsed=$(( now - alive_time ))
  
  # Only refresh if it has been some time.
  # we dont want to write to file every single iteration.
  if (( elapsed >= REFRESH_TIME )); then
    
    if (( elapsed >= alive_window )); then
      # Too much time not responding, stop
      echo "$(hostname): watch.sh: warning: took too long to update"
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
  echo "$(hostname): Sleeping for $sleep_time #$((i++))"
  sleep $sleep_time
  # After 4 times, sleep longer
  # to emulate unresponsiveness.
  #if [[ $times_refreshed -ge $TIMES_TO_TURN_UNRESPONSIVE ]]; then
  #  sleep_time=$((3*REFRESH_TIME))
  #fi
  if [[ -f "$DELAY_FILE" ]] ; then
    echo "$(hostname): Delaying for 1m"
    sleep 1m
    rm $DELAY_FILE
  fi
}
main() {
  i=0
		while true; do
    if [ -f "$TERMINATE_FILE" ] ; then
      delete_terminate_file
      break
    fi

    refresh
    work
  done

  echo "$(hostname) watch.sh: Emulating termination work for ${DELAY_BEFORE_TERMINATION}s"
  sleep $DELAY_BEFORE_TERMINATION
  echo "$(hostname) watch.sh: Terminated gracefully"
}


main "$@"
