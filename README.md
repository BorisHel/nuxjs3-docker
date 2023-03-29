# A WSL2 dockerized Nuxtjs 3 development environment boilerplate

This boilerplate is used to quick start a dockerised projet on WSL2 with hotReload

## Install Nextjs

Open the terminal of your choice and scaffold a new project with this command:

1. Install Nextjs 3
````
npx nuxi init .
````

2. Start our local development

Now we are ready to start our local development server on http://localhost:3000 with a simple command in our terminal:

````
docker-compose up
````


## How that work ?

Dockerization is done using Dockerfile and  docker-compose.yml.

### Dockerfile 
Dockerfile will be used to build our Docker image with all our Node dependencies including Node itself.

````
FROM node:14-alpine

WORKDIR /app

RUN apk update && apk upgrade

COPY ./package*.json /app/

RUN npm install && npm cache clean --force

COPY . .

ENV PATH ./node_modules/.bin/:$PATH
````

### docker-compose.yml

Define our services to tell Docker which containers need to spin up.
version: '3'

````
services:
  nuxt:
    build:
      context: .
    image: nuxt_dev
    container_name: nuxt_dev
    command: npm run dev
    volumes:
    - .:/app
    - /app/node_modules
    ports:
      - "3000:3000"
      - "24678:24678" # allow hotRelad on WSL2
````