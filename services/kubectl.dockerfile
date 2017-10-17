FROM progrium/busybox
WORKDIR /usr/bin
RUN mkdir /data && mkdir /root/.kube && \
		opkg-install curl && \
		curl -k -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -k -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x kubectl
WORKDIR /data