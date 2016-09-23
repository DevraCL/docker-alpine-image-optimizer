FROM alpine:edge
MAINTAINER scher200

# Install packages
RUN apk upgrade -U 
RUN apk --no-cache --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add \
    bc \
    bash \
    wget \
    optipng \
    jpegoptim

# Clean up
RUN rm -fr /var/cache/apk/*

# install dumb-init
RUN wget --no-check-certificate -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.1.1/dumb-init_1.1.1_amd64
RUN chmod +x /usr/local/bin/dumb-init

# Insert the root folder and overwrite the configuration files
COPY /rootfs /

VOLUME /images

ENTRYPOINT ["/usr/local/bin/dumb-init"]

CMD ["/shell/start.sh"]
