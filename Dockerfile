ARG ARCH=
FROM ${ARCH}alpine:latest

RUN apk update 
RUN apk upgrad
RUN apk add git rsync fio bash

CMD ["/bin/sh"]
