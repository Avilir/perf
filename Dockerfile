FROM alpine:latest
RUN apk update && apk add --no-cache rsync
RUN apk add --no-cache fio

