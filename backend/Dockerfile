# Stage 1: Install dependencies
FROM node:22-alpine AS builder

WORKDIR /backend

COPY package*.json ./

RUN npm ci

COPY . .

# Stage 2: Production image
FROM node:22-alpine

WORKDIR /backend

COPY --from=builder /backend ./

RUN npm prune --omit=dev

EXPOSE 5000

CMD ["node", "server.js"]