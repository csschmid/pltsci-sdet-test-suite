#!/bin/bash
# Purpose: Idempotently build and start the Cleaning Service docker container, and run tests against it
# Assumptions:
# 1. This script assumes it is executing from within the root directory of the test suite project,
#    and that one directory up, there exists the project directory for `pltsci-sdet-assignment`
# 2. The system has the following installed and accessible via commandline:
#    1. docker
#    2. awk
#    3. mvn (maven)
#    4. firefox

cd ../pltsci-sdet-assignment || exit 1

# build container
chmod +x service/run.sh
docker build -t pltsci-sdet-assignment service

# start container
docker run -d -p 8080:8080 pltsci-sdet-assignment

# You can check the logs for the running container with the following command
# docker logs -f `docker ps | awk '{if(NR>1){print $1}}'`

# Run tests
cd - || exit 1
mvn test

# open the cucumber report file in a browser
firefox target/cucumber-reports &

# Tear down docker container
docker kill "$(docker ps | grep pltsci-sdet-assignment | awk '{print $1}')"