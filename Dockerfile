ARG ARCH=
FROM ${ARCH}alpine:latest

RUN apk update 
RUN apk upgrad
RUN apk add git rsync fio bash

ADD https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.5.tar.gz /files//file.gz
COPY scripts/multiple_files.sh /opt/

CMD ["/bin/sh"]
