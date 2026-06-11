FROM node:22-alpine

WORKDIR /usr/src/app

RUN npm install -g pm2 pnpm

COPY ./server/package.json ./server/pnpm-lock.yaml ./

RUN chown -R node:node /usr/src/app

USER node

RUN pnpm i --frozen-lockfile

COPY --chown=node:node ./server .

RUN mkdir -p ../types

COPY --chown=node:node ./types ../types

EXPOSE 8000

CMD ["pm2-runtime", "pnpm", "--", "run", "start"]
