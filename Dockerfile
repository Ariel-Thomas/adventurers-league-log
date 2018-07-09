FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /app

ADD Gemfile Gemfile.lock Rakefile ./

RUN bundle install

COPY . /app
