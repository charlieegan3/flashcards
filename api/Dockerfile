FROM ruby:2.6

WORKDIR /app

COPY Gemfile* ./

RUN bundle install

COPY . .

CMD ["rails", "s", "-b", "0.0.0.0"]
