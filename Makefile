TAG ?= 0.0.2-ccdt
REPO_NAME ?= navidsh
RECEIVER_IMAGE_NAME ?= mq-sample-receiver
SENDER_IMAGE_NAME ?= mq-sample-sender

build-receiver:
	docker run -v $(CURDIR)/receiver:/usr/src/receiver -w /usr/src/receiver maven:3.6.3-jdk-8 mvn clean package
	cp receiver/target/receiver.war liberty-receiver

build-sender:
	docker run -v $(CURDIR)/sender:/usr/src/sender -w /usr/src/sender maven:3.6.3-jdk-8 mvn clean package
	cp sender/target/sender.war liberty-sender

push-receiver-image:
	docker build -t ${REPO_NAME}/${RECEIVER_IMAGE_NAME}:${TAG} ./liberty-receiver
	docker push ${REPO_NAME}/${RECEIVER_IMAGE_NAME}:${TAG}

push-sender-image:
	docker build -t ${REPO_NAME}/${SENDER_IMAGE_NAME}:${TAG} ./liberty-sender
	docker push ${REPO_NAME}/${SENDER_IMAGE_NAME}:${TAG}

build-push-receiver: build-receiver push-receiver-image

build-push-sender: build-sender push-sender-image

build-all: build-receiver build-sender

push-all: push-receiver-image push-sender-image

build-push-all: build-push-receiver build-push-sender