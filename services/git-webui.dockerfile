FROM python:3.6-alpine

RUN mkdir /data && \
		apk add --no-cache curl git && \
		curl https://raw.githubusercontent.com/alberthier/git-webui/master/install/installer.sh | sh
WORKDIR /data
EXPOSE 8000
CMD git webui

# docker run -it --rm -p 9000:8000 -v $(pwd):/data git-webui