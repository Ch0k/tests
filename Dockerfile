FROM ruby:2.7.2
RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs postgresql-client
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
