FROM node:8-jessie

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install

CMD ["yarn", "serve"]
