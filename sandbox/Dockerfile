FROM openjdk:11 as java
FROM node:15.0.1-alpine as node
FROM python:3.9.0-alpine as python
FROM golang:1.15.3-alpine as golang
FROM rust:1.47.0-alpine as rust
FROM alpine:3.12.0

RUN adduser --disabled-password user
ENV USER user

# clang, c++, and deps
RUN apk add --no-cache libc-dev gcc g++ make cmake tzdata

# java
COPY --from=java /usr/local/openjdk-11/bin /usr/local/openjdk-11/bin
ENV PATH $PATH:/usr/local/openjdk-11/bin/
ENV JAVA_HOME /usr/local/openjdk-11

# nodejs
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=node /usr/local/lib/node_modules/npm /usr/local/lib/node_modules/npm
COPY --from=node /opt/yarn* /opt/yarn
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn && \
    ln -fs /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

# python
COPY --from=python /usr/local/bin /usr/local/bin
COPY --from=python /usr/local/lib /usr/local/lib
COPY --from=python /usr/local/include /usr/local/include
RUN pip install pipenv

# golang
COPY --from=golang /usr/local/go /usr/local/go
ENV PATH $PATH:/usr/local/go/bin/

# rust
COPY --from=rust /usr/local/cargo /usr/local/cargo
COPY --from=rust /usr/local/rustup /usr/local/rustup
ENV PATH $PATH:/usr/local/cargo/bin/
ENV RUSTUP_HOME /usr/local/rustup

# common
USER user
WORKDIR /var/www/src