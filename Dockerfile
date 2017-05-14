FROM node:7.10-alpine

MAINTAINER Eric Maicon

RUN apk update
RUN apk add ca-certificates build-base wget zlib python
RUN update-ca-certificates
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install awscli

CMD ["aws"]