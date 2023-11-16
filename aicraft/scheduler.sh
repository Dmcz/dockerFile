#!/usr/bin/env bash

set -e

while [ true ]
    do
      php /deepcam/webserver_30000/artisan schedule:run &
      sleep 60
    done