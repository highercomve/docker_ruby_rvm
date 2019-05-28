# NOT WORKING YET
FROM alpine

ARG RUBY_VERSION=2.3.8
ENV RUBY_VERSION=$RUBY_VERSION LANG=C

# Dependencies for getting/building
RUN apk update; \
    apk add --no-cache \
        git gnupg bash curl alpine-sdk gcc musl-dev make \
        zlib zlib-dev openssl openssl-dev sqlite-dev

SHELL [ "/bin/bash", "-c"]

RUN gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
    && curl -sSL https://get.rvm.io | /bin/bash -s stable

RUN source /etc/profile.d/rvm.sh \
    && rvm install $RUBY_VERSION \
    && rvm use $RUBY_VERSION --default \
    && rvm rubygems current \
    && gem install bundler

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
