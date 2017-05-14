FROM node:7.10-alpine

MAINTAINER Eric Maicon

RUN apk update
RUN apk add ca-certificates build-base wget
RUN update-ca-certificates
RUN wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz
RUN tar -xzf Python-2.7.11.tgz  
RUN cd Python-2.7.11 && ./configure && make && make install
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install --upgrade --user awscli