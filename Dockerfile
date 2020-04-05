FROM node:8-jessie as frontend
RUN npm install -g yarn
WORKDIR /build

COPY frontend/package.json frontend/yarn.lock ./
RUN yarn install

COPY frontend .

RUN yarn build


FROM ruby:2.7
WORKDIR /app

COPY api/Gemfile* ./

RUN bundle install

COPY api .
RUN rm -rf tmp || true
RUN rm -rf public || true

COPY --from=frontend /build/dist /app/public

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=enabled
ENV RAILS_LOG_TO_STDOUT=true
CMD ["rails", "s", "-b", "0.0.0.0"]
