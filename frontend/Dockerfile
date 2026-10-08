FROM node:22-alpine AS build

WORKDIR /frontend

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build


FROM node:22-alpine AS production

WORKDIR /app

COPY --from=build /frontend/dist ./dist

RUN npm install -g serve@latest --no-save

EXPOSE 5173

CMD ["serve", "-s", "dist", "-l", "5173"]