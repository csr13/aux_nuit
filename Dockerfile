FROM ubuntu:focal
WORKDIR /home/root/tools
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt update && \
    apt install -y curl wget git ansible build-essential
COPY . .
