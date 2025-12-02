# ---------------- Builder Stage ----------------
FROM node:18-alpine AS builder
WORKDIR /app

# Copy dependency files only
COPY package.json package-lock.json ./

# Install ALL dependencies (including dev)
RUN npm ci

# Copy all application source code
COPY . .

# ---------------- Production Stage ----------------
FROM node:18-alpine
WORKDIR /app

# Copy only the dependency files
COPY package.json package-lock.json ./

# Install ONLY production dependencies
RUN npm ci --only=production

# Copy application code from builder
COPY --from=builder /app/app ./app

EXPOSE 8080

CMD ["node", "app/server.js"]
