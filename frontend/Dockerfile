FROM node:24-alpine AS build

WORKDIR /frontend

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build


FROM node:24-alpine AS production

WORKDIR /app

COPY --from=build /frontend/dist ./dist
COPY server.js .

EXPOSE 5173

CMD ["node", "server.js"]