FROM ubuntu:focal
ARG TAGS
WORKDIR /home/root
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt update && \
    apt install -y curl git ansible build-essential
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
