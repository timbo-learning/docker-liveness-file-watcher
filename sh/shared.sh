TERMINATE_FILE="terminate.txt"
ALIVE_FILE="alive.txt"
DELAY_FILE="delay.txt"

ALIVE_WINDOW="3"
STARTUP_ALIVE_WINDOW="7"
REFRESH_TIME="2"
sleep_time="${REFRESH_TIME}"

delete_terminate_file() {
  if [ -f "$TERMINATE_FILE" ]; then
    rm "$TERMINATE_FILE"
  fi
}

unix_time_in_seconds() {
  date +%s
}

refresh_alive_time() {
  if [[ -z "$1" ]]; then
    local _alive_window=$alive_window
  else
    local _alive_window=$1
  fi
  echo "$(hostname) alive!"
  echo -n "$(unix_time_in_seconds),$_alive_window" > "$ALIVE_FILE"
  ((times_refreshed++))
}

# Format of $ALIVE_FILE: alive_time,alive_window
# alive_time  : last time in seconds app was alive
# alive_window: time interval in which the app is considered alive.
#
#               If it has been $alive_window seconds and $alive_time
#               from file hasnt been updated. The application is
#               considered unresponsive/not working and will be
#               killed.
read_alive_time() {
    IFS=',' read alive_time alive_window < "$ALIVE_FILE"
}
