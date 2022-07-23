FROM ruby:2.7-slim

RUN set -ex \
    && apt update \
    && apt install -y --no-install-recommends build-essential git

RUN mkdir /app

# COPY Gemfile Gemfile.lock /app/

WORKDIR /app
# RUN bundle install
# RUN bundle binstubs --all --path /bin

COPY . /app

ENV HISTCONTROL=ignoreboth:erasedups

ENTRYPOINT ["bash"]
