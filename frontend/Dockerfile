# Stage 1: Build
FROM node:24-alpine AS build

WORKDIR /frontend

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build


# Stage 2: Production
FROM node:24-alpine AS production

WORKDIR /app

COPY --from=build /frontend/dist ./dist
COPY server.js .

# npm is not required at runtime
RUN rm -rf /usr/local/lib/node_modules/npm \
           /usr/local/bin/npm \
           /usr/local/bin/npx

EXPOSE 5173

CMD ["node", "server.js"]