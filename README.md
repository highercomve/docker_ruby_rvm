Ruby container with RVM
=======================

This container is intended to be a base container for other Dockerfiles. The motivation to have a container with RVM is because the [official ruby image](https://hub.docker.com/_/ruby/) only has version from ruby and more. And escuelaweb need to support other versions of ruby

## How to use it

You could build a container if you want to use ruby from a container

```bash
docker build --build-arg RUBY_VERSION=2.6.3 highercomve/ruby-rvm
```

The default RUBY_VERSION is 2.3.8

After building the image you could check that the version is correct by running the container.

Examples:

```bash
$ docker run -it ruby-rvm ruby -v
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
```

```bash
$ docker run -it ruby-rvm rvm list
=* ruby-2.6.3 [ x86_64 ]

# => - current
# =* - current && default
#  * - default
```

```bash
$ docker run -it ruby-rvm gem -v
3.0.3
```

## How to use it as base for another image

Rails example
```
# ARG RUBY_VERSION=2.6.3
FROM highercomve/ruby-rvm

COPY . .

ENV RACK_ENV=prod RAILS_ENV=prod

# Before running anything related to ruby first source rvm
RUN source /etc/profile.d/rvm.sh \
    && gem install foreman \
    && bundle install

CMD bundle exec foreman start
```