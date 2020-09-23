#!/bin/bash
source ./set_tag
docker run -v $(pwd)/receiver:/usr/src/receiver -w /usr/src/receiver maven:3.6.3-jdk-8 mvn clean package
cp receiver/target/receiver.war liberty-receiver
docker build -t navidsh/mq-sample-receiver:${TAG} ./liberty-receiver
docker push navidsh/mq-sample-receiver:${TAG}
