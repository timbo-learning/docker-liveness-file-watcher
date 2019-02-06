#!/bin/bash 
#===============================================================================
#
#          FILE: push-to-local-docker-registry.sh
# 
#         USAGE: ./push-to-local-docker-registry.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 02/ 6/2019 16:06
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

docker build -t timbo/alive .
docker stop registry
docker rm registry
docker run -d -p 5000:5000 --restart=always --name registry registry:2
docker tag timbo/alive localhost:5000/timbo/alive
docker push localhost:5000/timbo/alive
