FROM ruby:2.7.1

WORKDIR /app

COPY Gemfile* ./

RUN bundle install

COPY . .
RUN rm -rf tmp || true

CMD ["rails", "s", "-b", "0.0.0.0"]
