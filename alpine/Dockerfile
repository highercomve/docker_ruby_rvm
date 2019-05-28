# NOT WORKING YET
FROM alpine

ARG RUBY_VERSION=2.3.8
ENV RUBY_VERSION=$RUBY_VERSION LANG=C

# Dependencies for getting/building
RUN apk update; \
    apk add --no-cache \
        git gnupg bash curl alpine-sdk gcc procps musl-dev make linux-headers \
        zlib zlib-dev openssl openssl-dev sqlite-dev

SHELL [ "/bin/bash", "-c"]

RUN curl -sSL https://gist.github.com/ashsmith/55098099d2a5b5dfed9935dd4488abd6/raw/9113834d220fca40ed69e53c198a8891a4357d8e/ps_opt_p_enabled_for_alpine.sh -o /usr/local/bin/ps \
  && chmod 755 /usr/local/bin/ps

RUN curl -sSL https://github.com/rvm/rvm/archive/stable.tar.gz -o rvm-stable.tar.gz \
    && echo 'export rvm_prefix="$HOME"' > /root/.rvmrc \
    && echo 'export rvm_path="$HOME/.rvm"' >> /root/.rvmrc \
    && mkdir rvm && cd rvm \
    && tar -xzf ../rvm-stable.tar.gz \
    && cd rvm-stable \
    && ./scripts/install \
    && cd ../../ \
    && rm -rf stable.tar.gz rvm

RUN source /root/.rvm/scripts/rvm \
    && rvm install --disable-binary --autolibs=0 $RUBY_VERSION \
    && rvm use $RUBY_VERSION --default \
    && rvm rubygems current \
    && gem install bundler

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
