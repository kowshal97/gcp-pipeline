FROM node:20-alpine

ENV NODE_ENV=production

# App folder
WORKDIR /app

# Copy package files and install deps as root
COPY package*.json ./
RUN npm ci --only=production

# Copy source code
COPY . .

# Now drop privileges (best practice)
RUN addgroup -S app && adduser -S app -G app
USER app

EXPOSE 3000
CMD ["node", "src/index.js"]
