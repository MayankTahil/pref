FROM progrium/busybox
RUN mkdir /data && \
		opkg-install curl && \
		curl -k -L https://github.com/kubernetes/kompose/releases/download/v1.2.0/kompose-linux-amd64 -o /usr/bin/kompose && \
		chmod +x /usr/bin/kompose
WORKDIR /data
ENTRYPOINT [ "kompose" ]
CMD [""]