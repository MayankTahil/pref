FROM mayankt/kubectl-cli
RUN opkg-install curl && \
		curl -k -L https://github.com/kubernetes/kompose/releases/download/v1.2.0/kompose-linux-amd64 -o /usr/bin/kompose && \
		chmod +x /usr/bin/kompose
WORKDIR /data