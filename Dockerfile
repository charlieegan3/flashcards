FROM node:8-jessie
WORKDIR /build

COPY frontend/package.json frontend/yarn.lock ./
RUN yarn install

COPY frontend .

RUN yarn build
