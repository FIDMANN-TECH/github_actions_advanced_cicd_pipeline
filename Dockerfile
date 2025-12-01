FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --production=false
COPY . .
RUN npm run test

FROM node:18-alpine
WORKDIR /app
COPY package.json ./
RUN npm ci --production
COPY app ./app
EXPOSE 8080
CMD ["node", "app/server.js"]
