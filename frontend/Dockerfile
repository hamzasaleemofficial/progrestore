FROM node:24-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

RUN npm install -g serve@latest

EXPOSE 5173

CMD ["serve", "-s", "dist", "-l", "5173"]