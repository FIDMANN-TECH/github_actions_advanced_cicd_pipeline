FROM node:18-alpine AS builder
WORKDIR /app

# Copy dependency files first
COPY package.json package-lock.json ./
RUN npm ci --production=false

# Copy application code
COPY . .
RUN npm test

# -------- Release stage --------
FROM node:18-alpine
WORKDIR /app

# Copy dependency files
COPY package.json package-lock.json ./
RUN npm ci --production

# Copy only production app files
COPY app ./app

EXPOSE 8080
CMD ["node", "app/server.js"]
