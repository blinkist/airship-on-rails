FROM ruby:2.3.6-alpine
MAINTAINER operations@blinkist.com

LABEL APP_NAME=airship-on-rails

ENV BUILD_PACKAGES build-base git
ENV RUNTIME_PACKAGES mysql-dev
ENV RAILS_ENV=production APP_NAME=airship-on-rails LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8 LC_CTYPE=C.UTF-8

RUN mkdir /app && echo 'gem: --no-document' >> ~/.gemrc

WORKDIR /app
COPY Gemfile* /app/

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUNTIME_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN bundle install --jobs 20 --retry 5 --without development test

RUN apk del $BUILD_PACKAGES

ADD . /app

RUN chown -R nobody:nogroup /app

USER nobody

EXPOSE 3000

CMD sh /app/bin/dispatch.sh
