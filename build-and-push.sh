#!/bin/bash
docker pull php:7.4 || true
docker pull riamehdi/laravel-docker:7.4 || true
docker build --compress --cache-from riamehdi/laravel-docker:7.4 --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" -t riamehdi/laravel-docker:7.4 -f 7.4/Dockerfile .
docker run -t --rm -v "$(pwd)":/var/www/html riamehdi/laravel-docker:7.4 goss -g tests/goss-7.4.yaml v
docker tag riamehdi/laravel-docker:7.4 riamehdi/laravel-docker:7.4
docker push riamehdi/laravel-docker:7.4
