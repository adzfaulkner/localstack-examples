localstack-up:
	docker-compose up -d

serverless-up:
	cd src/serverless && sh ./run.sh

sns-sqs-lamda-up:
	cd src/sns_sqs_lamda && make setup

sns-sqs-lamda-publish-message:
	cd src/sns_sqs_lamda && make publish-message

sns-sqs-lamda-tail-log:
	cd src/sns_sqs_lamda && make tail-log