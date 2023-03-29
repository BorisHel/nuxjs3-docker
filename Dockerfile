FROM node:14-alpine

WORKDIR /app

RUN apk update && apk upgrade

COPY ./package*.json /app/

RUN npm install && npm cache clean --force

COPY . .

ENV PATH ./node_modules/.bin/:$PATH