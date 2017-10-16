FROM docker:stable-dind 

# docker run --privileged --name=sandbox -dt -v ./data:/data -v config:/kube/config mayankt/backdoor ; docker exec -it sandbox /bin/bash

RUN apk add --no-cache \
 sudo \
 curl \
 git \
 screen \
 htop \
 openssh \
 autossh \
 bash-completion \
 nano \
 tcpdump \
 coreutils

# Install kubctl in the container and set default config file in /kube directory
WORKDIR /usr/local/bin
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.7.1/bin/linux/amd64/kubectl && \
 chmod +x kubectl && mkdir /kube && \
 echo 'export KUBECONFIG=/kube/config' >> /etc/profile && \
 mkdir /etc/docker && \
 echo "{ \"insecure-registries\":[\"registry.store:5000\"] }" > /etc/docker/daemon.json
WORKDIR /data
CMD dockerd >/dev/null 2>/dev/null & bash