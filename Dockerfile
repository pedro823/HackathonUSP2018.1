FROM ruby:latest
RUN apt update -qq && apt install -y build-essential libpq-dev nodejs
RUN mkdir /hack
WORKDIR /hack
COPY ./Gemfile /hack/Gemfile
COPY ./Gemfile.lock /hack/Gemfile.lock
RUN bundle install
RUN bundle
COPY . /hack
RUN bundle exec rake db:create
RUN bundle exec rake db:migrate
