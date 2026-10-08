FROM node:24-alpine AS build

WORKDIR /frontend

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build


FROM node:24-alpine AS production

WORKDIR /app

COPY --from=build /frontend/dist ./dist

RUN npm install -g serve@14.2.6 --no-save

EXPOSE 5173

CMD ["serve", "-s", "dist", "-l", "5173"]