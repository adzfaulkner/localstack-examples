#!/bin/sh
set -e

# var set up
API_NAME=test
REGION=eu-west-2
STAGE=test

# ensure localstack is running etc
sh ../../wait-for localhost:4566 -- echo "LocalStack is up and running" || (echo "LocalStack not running"; exit 1)

# create the binary
docker build -f ../../Dockerfile_go --tag build_serverless .
docker run --rm -v "${PWD}/build":/go/src/app/build build_serverless go build -o ./build main.go

serverless deploy --stage local