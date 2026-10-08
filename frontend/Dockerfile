# Stage 1: Build
FROM node:24-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build


# Stage 2: Production with Alpine (secure & lightweight)
FROM node:24-alpine AS production

WORKDIR /app

RUN npm install -g serve@14.2.6 --no-save --legacy-peer-deps && \
    npm cache clean --force && \
    rm -rf /root/.npm

COPY --from=build /app/dist ./dist

EXPOSE 5173

CMD ["serve", "-s", "dist", "-l", "5173"]