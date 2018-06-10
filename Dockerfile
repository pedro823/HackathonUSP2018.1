FROM ruby:2.3
 
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
 
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*
 
COPY Gemfile /usr/src/app/
 
RUN bundle install
 
COPY . /usr/src/app
 
EXPOSE 3000
CMD puma -C config/puma.rb
