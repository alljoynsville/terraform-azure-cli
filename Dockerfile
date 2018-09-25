FROM golang:alpine
MAINTAINER "Nico Lindemann <nico.lindemann@proux.net>"

# Configure the Terraform version here
ENV TERRAFORM_VERSION=0.11.8

RUN apk update && \
apk add --update curl git bash openssh zip vim && \
apk add bash py-pip make zip zlib zlib-dev libressl libressl-dev && \
apk add --virtual=build gcc libffi-dev python-dev musl-dev python-dev && \
pip install  --no-cache-dir --pre azure-cli --extra-index-url https://azurecliprod.blob.core.windows.net/edge && \
apk del --purge build

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
git checkout v${TERRAFORM_VERSION} && \
/bin/bash scripts/build.sh
WORKDIR /root
