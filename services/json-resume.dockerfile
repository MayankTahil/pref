FROM node:8-alpine
RUN mkdir /data && \
  apk --no-cache add git && \
  npm install phantomjs-prebuilt@2.1.13 && \
  npm install -g resume-cli && \
  npm install -g jsonresume-theme-elegant && \
  npm install -g jsonresume-theme-slick && \
  npm install -g jsonresume-theme-kendall && \
  npm install -g jsonresume-theme-papirus && \
  npm install -g jsonresume-theme-riga && \
  npm install -g jsonresume-theme-juno && \
	npm install -g jsonresume-theme-spartacus
RUN 	npm install -g jsonresume-theme-fresh
WORKDIR /data
CMD bash