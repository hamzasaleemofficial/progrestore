FROM node:24-alpine AS dependencies

WORKDIR /backend

COPY package*.json ./

RUN npm ci --omit=dev

FROM node:24-alpine AS production

WORKDIR /backend

COPY --from=dependencies /backend/node_modules ./node_modules
COPY . .

RUN rm -rf /usr/local/lib/node_modules/npm \
           /usr/local/bin/npm \
           /usr/local/bin/npx

EXPOSE 5000

CMD ["node", "server.js"]