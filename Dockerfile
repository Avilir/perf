ARG ARCH=
FROM ${ARCH}alpine:latest
RUN apk update 
RUN apk add rsync
RUN apk add fio

CMD ["/bin/sh"]

