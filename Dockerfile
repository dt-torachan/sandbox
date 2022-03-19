FROM node:15.0.1-alpine as node
FROM python:3.9.0-alpine as python
FROM golang:1.15.3-alpine as golang
FROM rust:1.47.0-alpine as rust
FROM debian:stable
# FROM alpine:3.12.0

RUN adduser --disabled-password user
ENV USER user
RUN apt-get update
RUN apt-get upgrade

# clang, c++, and deps
RUN apt-get install -y libc-dev gcc g++ make cmake tzdata bash

# c#(mono)
RUN apt-get install -y gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get install -y mono-devel

# php
RUN apt-get install -y php7 php7-fpm php7-opcache

# java
RUN apt-get install -y openjdk-11-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"

# nodejs
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=node /usr/local/lib/node_modules/npm /usr/local/lib/node_modules/npm
COPY --from=node /opt/yarn* /opt/yarn
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn && \
    ln -fs /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

#php
RUN apt-get install -y php

# python
COPY --from=python /usr/local/bin /usr/local/bin
COPY --from=python /usr/local/lib /usr/local/lib
COPY --from=python /usr/local/include /usr/local/include
RUN apt-get install -y python3-pip
RUN pip install pipenv

# golang
RUN apt-get install -y golang-go

# rust
COPY --from=rust /usr/local/cargo /usr/local/cargo
COPY --from=rust /usr/local/rustup /usr/local/rustup
ENV PATH $PATH:/usr/local/cargo/bin/
ENV RUSTUP_HOME /usr/local/rustup

# ruby
RUN apt-get install -y ruby

# dart
RUN apt-get install -y apt-transport-https wget
RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list
RUN apt-get update
RUN apt-get install -y dart

# common
USER user
WORKDIR /var/www/src