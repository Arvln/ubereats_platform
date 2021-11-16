FROM node:alpine

WORKDIR /usr/src/app

COPY ./app/package*.json .

RUN npm install -g pm2 && npm install

COPY ./app .

RUN mkdir -p ../types

COPY ./types ../types

ENV NODE_OPTIONS=--openssl-legacy-provider

EXPOSE 3000

USER node

CMD ["pm2-runtime", "npm run dev"]
