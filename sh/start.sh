#!/bin/bash - 
#===============================================================================
#
#          FILE: start.sh
# 
#         USAGE: ./start.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 02/ 5/2019 13:43
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

source ./scripts/shared.sh


create_initial_alive_file() {
  times_refreshed=0
  refresh_alive_time $STARTUP_ALIVE_WINDOW

}

run_app() {
  ./scripts/watch.sh
}

main() {
  delete_terminate_file
  create_initial_alive_file

  run_app
}

main "$@"
