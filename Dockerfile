# The base image is the latest 8.x node (LTS)
FROM node:8.11.4@sha256:3422df4f7532b26b55275ad7b6dc17ec35f77192b04ce22e62e43541f3d28eb3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV redis:host=redis
COPY install/package.json /usr/src/app/package.json
RUN npm i npm@latest -g
RUN npm install && npm cache clean --force
COPY . /usr/src/app

# wait-for-it file
COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

ENV NODE_ENV=production \
    daemon=false \
    silent=false

# CMD ./nodebb start

# the default port for NodeBB is exposed outside the container
EXPOSE 4567