# ---------- Builder Stage ----------
FROM node:18-alpine AS builder
WORKDIR /app

# Copy dependency files
COPY package.json package-lock.json ./
RUN npm ci

# Copy application code
COPY . .

# Run tests (Jest)
RUN npm test

# ---------- Production Stage ----------
FROM node:18-alpine
WORKDIR /app

# Copy only necessary files
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Copy built application
COPY app ./app

EXPOSE 8080
CMD ["node", "app/server.js"]
