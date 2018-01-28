FROM golang:alpine
MAINTAINER "Nico Lindemann <nico.lindemann@proux.net>"

# Configure the Terraform version here
ENV TERRAFORM_VERSION=0.11.2

RUN apk add --update git bash openssh zip

# install azure cli
RUN apk update && \
apk add bash py-pip make zip && \
apk add --virtual=build gcc libssl-dev libffi-dev python-dev musl-dev openssl-dev python-dev && \
pip install azure-cli && \
apk del --purge build

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
git checkout v${TERRAFORM_VERSION} && \
/bin/bash scripts/build.sh

# Start in root's home
WORKDIR /root
