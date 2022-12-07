# syntax=docker/dockerfile:1
FROM alpine:3
RUN apk add openjdk8
COPY ./user-microservice/target/user-microservice-0.1.0.jar .
CMD java -DAPP_PORT=${APP_PORT} \
-DDB_USERNAME=${DB_USERNAME} \
-DDB_PASSWORD=${DB_PASSWORD} \
-DDB_HOST=${DB_HOST} \
-DDB_PORT=${DB_PORT} \
-DDB_NAME=${DB_NAME} \
-DENCRYPT_SECRET_KEY=${ENCRYPT_SECRET_KEY} \
-DJWT_SECRET_KEY=${JWT_SECRET_KEY} \
-jar user-microservice-0.1.0.jar
EXPOSE 8071
