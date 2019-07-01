FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /scraper
WORKDIR /scraper
COPY Gemfile /scraper/Gemfile
COPY Gemfile.lock /scraper/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /scraper

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
