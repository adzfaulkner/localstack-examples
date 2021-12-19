# Localstack Examples

## Purpose

There's various blog posts out there prescribing how to build various solutions that leverage localstack and I thought it would be worth consolidating and cataloging in a repo.

## Prerequisites

1. Docker
2. docker-compose

## Executing

### Initial setup

1. Clone this repo and cd into it
2. Execute `docker-compose up` to bring up localstack
3. Execute `chmod +x wait-for`

#### Serverless

1. Execute `make serverless-up`
2. Copy endpoint URL rendered in a dialog and paste it into a rest client / browser and add /get/{slug} on the end i.e. http://localhost:4566/restapis/{id}}/local/_user_request_/get/adam

#### SNS SQS Lamda

1. Execute `make sns-sqs-lamda-up`
2. Execute `make sns-sqs-lamda-tail-log` to tail the lamda logs
3. Open up another pane (or termial tab) and execute `make publish-message` and watch the message appear in the log upon every execution

## Todo

1. Add more examples
2. Add more serverless endpoints
3. Possibly look into mounting the go binaries into localstack as volumes to speed uop performance
