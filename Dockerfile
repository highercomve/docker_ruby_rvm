FROM ubuntu

ARG RUBY_VERSION=2.3.8
ENV RUBY_VERSION=$RUBY_VERSION LANG=C

# Dependencies for getting/building
RUN apt-get update \
    && apt-get install  -y \
        gnupg2 curl libssl-dev git gawk g++ gcc autoconf automake libreadline-dev \
        bison libc6-dev libffi-dev libgdbm-dev libncurses5-dev libpq-dev \
        libtool libyaml-dev make pkg-config sqlite3 libsqlite3-dev  \
        zlib1g-dev libgmp-dev libcurl4-gnutls-dev 

RUN gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
    && curl -sSL https://get.rvm.io | /bin/bash -s stable \
    && usermod -a -G rvm root

SHELL [ "/bin/bash", "-c"]

RUN source /etc/profile.d/rvm.sh \
    && rvm install $RUBY_VERSION \
    && rvm use $RUBY_VERSION --default \
    && rvm rubygems current \
    && gem install bundler

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

RUN apt-get update && apt-get autoremove -y && rm -rf /var/cache/apt/archives

ENTRYPOINT ["docker-entrypoint.sh"]
