FROM docker:stable-dind 

# docker run --privileged --name=sandbox -dt -v ./data:/data -v config:/kube/config mayankt/backdoor ; docker exec -it sandbox /bin/bash
EXPOSE 9000-9010

RUN apk add --no-cache \
 sudo \
 curl \
 git \
 grep \
 screen \
 htop \
 openssh \
 openssl \
 autossh \
 bash \
 bash-doc \
 bash-completion \
 nano \
 tcpdump \
 coreutils \
 py-pip

RUN pip install docker-compose

# Install kubctl in the container and set default config file in /kube directory
WORKDIR /usr/local/bin
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.7.1/bin/linux/amd64/kubectl && \
	 	chmod +x kubectl && mkdir /kube && \
 		echo 'export KUBECONFIG=/kube/config' >> /etc/profile
RUN mkdir /etc/docker && \
 		echo "{ \"insecure-registries\":[\"registry.store:5000\"] }" > /etc/docker/daemon.json && \
 		mkdir /root/.kube && touch /root/.kube/config && \
 		echo "source <(kubectl completion bash)" >> ~/.bashrc
RUN curl -k https://kubernetes-helm.storage.googleapis.com/helm-v2.6.2-linux-amd64.tar.gz | tar xvz && mv linux-amd64/helm ./ && rm -rf linux-amd64
WORKDIR /data


CMD dockerd >/dev/null 2>/dev/null & bash