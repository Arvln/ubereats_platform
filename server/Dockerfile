FROM node:alpine

WORKDIR /usr/src/app

COPY ./server/package.json .

RUN npm install -g pm2 && npm install -g pnpm && pnpm i

COPY ./server .

RUN mkdir -p ../types

COPY ./types ../types

EXPOSE 8000

USER node

CMD ["pm2-runtime", "pnpm", "--", "run", "start"]
