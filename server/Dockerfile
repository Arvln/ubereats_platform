FROM node:alpine

WORKDIR /usr/src/app

COPY ./server/package*.json ./

RUN npm install -g pm2 && npm install

COPY ./server .

RUN mkdir -p ../types

COPY ./types ../types

EXPOSE 8000

USER node

CMD ["pm2-runtime", "npm", "--", "start"]
