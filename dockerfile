FROM ruby:2.5.1

ENV LANG=C.UTF-8

RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential libpq-dev mysql-client vim imagemagick

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
    && apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

WORKDIR /app
RUN gem install bundler
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --jobs=4 --retry=5
ADD . /app
