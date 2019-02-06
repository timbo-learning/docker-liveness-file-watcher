#!/bin/bash 
#===============================================================================
#
#          FILE: session.sh
# 
#         USAGE: ./session.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 02/ 6/2019 12:06
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
set -x
set -e

CONTAINER_NAME="watcher-$$"
docker build -t timbo/alive .
mintty -p left docker run --name $CONTAINER_NAME timbo/alive &
sleep 1s
mintty -p center docker exec -i $CONTAINER_NAME /bin/bash -c "while true; do ./sh/alive.sh; done" &
sleep 18s
mintty -p right docker exec -i $CONTAINER_NAME /sh/stop.sh
wait
