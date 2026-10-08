FROM node:22-alpine AS build

WORKDIR /frontend

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build


FROM node:22-alpine AS production

WORKDIR /app

COPY --from=build /frontend/dist ./dist

RUN npm install -g http-server

EXPOSE 5173

CMD ["http-server", "dist", "-p", "5173"]