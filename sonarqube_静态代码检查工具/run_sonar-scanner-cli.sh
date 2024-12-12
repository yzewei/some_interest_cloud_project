#!/bin/bash

docker run \
    --rm \
    -e SONAR_HOST_URL="http://10.130.0.19:9123" \
    -e SONAR_SCANNER_OPTS="-Dsonar.projectKey=abi2.0 -Dsonar.sources=/usr/src -Dsonar.host.url=http://10.130.0.19:9123 -Dsonar.login=sqp_f6032c4fcee16f8d40f5569290dfe2b580ea1e74" \
    -e SONAR_LOGIN="sqp_f6032c4fcee16f8d40f5569290dfe2b580ea1e74" \
    -v "/home/yzw/sonarqube/docker-library:/usr/src" \
    sonarsource/sonar-scanner-cli
