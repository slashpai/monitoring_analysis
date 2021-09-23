FROM ruby:2.7.3

ARG VERSION="0.1.0"

WORKDIR /usr/src/app

COPY . .

RUN gem build && gem install prom_check-${VERSION}.gem

USER 1001
