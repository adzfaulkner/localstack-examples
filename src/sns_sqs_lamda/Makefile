API_NAME=test
REGION=eu-west-2
STAGE=test

setup:
	sh ../../wait-for localhost:4566 -- echo "LocalStack is up and running" || (echo "LocalStack not running"; exit 1)

	docker build -f ../../Dockerfile_go --tag build_sns .
	docker run --rm -v "${PWD}/build":/go/src/app/build build_sns go build -o ./build main.go
	cd build && zip function.zip main

	aws sns create-topic \
		--endpoint-url http://localhost:4566 \
		--name ${API_NAME}_sns

	aws sqs create-queue \
		--endpoint-url http://localhost:4566 \
		--queue-name ${API_NAME}_queue

	aws lambda create-function \
		--endpoint-url http://localhost:4566 \
		--function-name ${API_NAME}_func \
		--runtime go1.x \
		--role arn:aws:iam::123456:role/irrelevant \
		--handler main \
		--zip-file fileb://build/function.zip

	aws lambda create-event-source-mapping  \
		--endpoint-url http://localhost:4566 \
		--function-name ${API_NAME}_func \
		--batch-size 5 \
		--maximum-batching-window-in-seconds 60 \
		--event-source-arn arn:aws:sqs:${REGION}:000000000000:${API_NAME}_queue

	aws sns subscribe \
		--endpoint-url http://localhost:4566 \
		--topic-arn arn:aws:sns:${REGION}:000000000000:${API_NAME}_sns \
		--protocol sqs \
		--notification-endpoint http://localhost:4566/000000000000/${API_NAME}_queue 

	aws sns subscribe \
		--endpoint-url http://localhost:4566 \
		--topic-arn arn:aws:sns:${REGION}:000000000000:${API_NAME}_sns \
		--protocol sqs \
		--notification-endpoint http://localhost:4566/000000000000/${API_NAME}_queue 

publish-message:		
	aws sns publish \
    	--endpoint-url http://localhost:4566 \
    	--topic-arn arn:aws:sns:${REGION}:000000000000:${API_NAME}_sns \
    	--message 'Hi there I am only testing'

tail-log:
	aws --endpoint-url=http://localhost:4566 logs tail /aws/lambda/${API_NAME}_func --follow 