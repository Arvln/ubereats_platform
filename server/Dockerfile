FROM node:18.17.1-alpine

WORKDIR /usr/src/app

COPY ./server/package.json ./server/pnpm-lock.yaml .

RUN npm install -g pm2 && npm install -g pnpm && pnpm i --frozen-lockfile

COPY ./server .

RUN mkdir -p ../types

COPY ./types ../types

EXPOSE 8000

USER node

CMD ["pm2-runtime", "pnpm", "--", "run", "start"]
